{ pkgs, lib }:
{
  # Helper generating UUID based on string
  mkUuid =
    string:
    let
      hash = builtins.hashString "md5" string;
      sub = l: r: builtins.substring l r hash;
    in
    "${sub 0 8}-${sub 8 4}-${sub 12 4}-${sub 16 4}-${sub 20 12}";

  # Normalize RAM param
  normalizeMemory =
    memory:
    if builtins.isInt memory then
      {
        count = memory;
        unit = "GiB";
      }
    else
      memory;

  # Normalize vCPU param
  normalizeVcpu =
    vcpu:
    if builtins.isInt vcpu then
      {
        count = vcpu;
        placement = "static";
      }
    else
      vcpu;

  # Host OS detection
  getHostOS =
    system:
    if builtins.match ".*-linux" system != null then
      "linux"
    else if builtins.match ".*-darwin" system != null then
      "darwin"
    else
      "unknown";

  # Host architecture detection
  getHostArch =
    system:
    if builtins.match "x86_64-.*" system != null then
      "x86_64"
    else if builtins.match "aarch64-.*" system != null then
      "aarch64"
    else
      "unknown";

  # Hypervisor type selection
  getHypervisorType =
    hostOS: hostArch: arch:
    if hostOS == "linux" && arch == hostArch then
      "kvm"
    else if hostOS == "darwin" && arch == hostArch then
      "hvf"
    else
      "qemu";

  # Machine type selection
  getMachineType =
    machineType: arch:
    if machineType != null then
      machineType
    else if arch == "aarch64" then
      "virt"
    else
      "q35";
}
