{ pkgs, lib, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  name,
  uuid ? null,
  memory ? {
    count = 2;
    unit = "GiB";
  },
  vcpu ? {
    count = 2;
    placement = "static";
  },
  arch ? "x86_64",
  machineType ? null,
  disks ? null,
}:
let
  # Helper generating UUID baased on string
  mkUuid =
    string:
    let
      hash = builtins.hashString "md5" string;
      sub = l: r: builtins.substring l r hash;
    in
    "${sub 0 8}-${sub 8 4}-${sub 12 4}-${sub 16 4}-${sub 20 12}";

  # Use user provided uuid or fallback to random one
  effectiveUuid = if uuid != null then uuid else mkUuid name;

  # Host OS detection
  hostOS =
    if builtins.match ".*-linux" system != null then
      "linux"
    else if builtins.match ".*-darwin" system != null then
      "darwin"
    else
      "unknown";

  # Host architecture detection
  hostArch =
    if builtins.match "x86_64-.*" system != null then
      "x86_64"
    else if builtins.match "aarch64-.*" system != null then
      "aarch64"
    else
      "unknown";

  # Hypervisor type selection
  effectiveHypervisorType =
    if hostOS == "linux" && arch == hostArch then
      "kvm"
    else if hostOS == "darwin" && arch == hostArch then
      "hvf"
    else
      "qemu";

  # Machine type selection
  effectiveMachineType =
    if machineType != null then
      machineType
    else if arch == "aarch64" then
      "virt"
    else
      "q35";

  effectiveEmulatorPath = "${pkgs.qemu}/bin/qemu-system-${arch}";

  # Single disk generator
  mkDisk =
    index: diskInfo:
    let
      path = diskInfo.path;
      # TODO: You can deduce it as well!
      serialNumber = diskInfo.serial or null;

      # Use user provided serial or generate one
      effectiveSerialNumber =
        if serialNumber != null then serialNumber else "generic-sn-${toString index}";

      # Check if provided path is block device
      isBlock = builtins.match "^/dev/.*" path != null;
      # Detect NVME drives
      isNvme = builtins.match ".*nvme.*" path != null;

      # Check if provided path is qcow2 file
      isQcow2 = builtins.match ".*\\.qcow2$" path != null;
      # Check if provided path is iso file
      isIso = builtins.match ".*\\.iso$" path != null;

      # Bus type selection
      busType =
        if isIso then
          "sata"
        else if isNvme then
          "nvme"
        else if isBlock then
          "sata"
        else
          "virtio";

      alphabet = "abcdefghijklmnopqrstuvwxyz";
      diskLetter = if index < 26 then builtins.substring index 1 alphabet else throw "Too many disks!";

      targetDev =
        if busType == "nvme" then
          "nvme${toString index}n1"
        else if busType == "sata" then
          "sd" + diskLetter
        else
          "vd" + diskLetter;
    in
    {
      device = if isIso then "cdrom" else "disk";
      # TODO: Extend to handle volumes/network later
      type = if isBlock then "block" else "file";

      driver = {
        name = "qemu";
        type = if isQcow2 then "qcow2" else "raw";
      };

      source = if isBlock then { dev = path; } else { file = path; };

      target = {
        dev = targetDev;
        bus = busType;
      };

    }
    // (if isIso then { readonly = true; } else { })
    // (if isBlock then { serial = effectiveSerialNumber; } else { });

  mkDisks =
    disksInfo:
    let
      normalizeItem =
        item:
        if builtins.isString item then
          { path = item; }
        else if builtins.isAttrs item && item ? path then
          item
        else
          throw "Invalid disk input: expected a string path or an attribute set with a 'path' attribute.";

      normalizedList =
        if disksInfo == null then
          [ ]
        else if builtins.isString disksInfo then
          [ { path = disksInfo; } ]
        else if builtins.isAttrs disksInfo then
          [ disksInfo ]
        else if builtins.isList disksInfo then
          map normalizeItem disksInfo
        else
          throw "Unsupported disk input type.";
    in
    lib.imap0 mkDisk normalizedList;
in
{
  # TODO: Consider assert if exceeding limits
  # RAM, vCPU cores,
  inherit name memory vcpu;

  uuid = effectiveUuid;
  type = effectiveHypervisorType;

  os = {
    inherit arch;

    type = "hvm";
    machine = effectiveMachineType;

    boot = [
      { dev = "hd"; }
      { dev = "cdrom"; }
    ];
  };

  cpu = {
    # Mimic host's physical CPU
    mode = "host-passthrough";
    # Drop VM live-migration but increase performance
    migratable = false;
  };

  devices = {
    emulator = effectiveEmulatorPath;
    disk = mkDisks disks;
  };
}
