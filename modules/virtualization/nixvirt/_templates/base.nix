{ pkgs, lib, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  libVirt = import ../_lib { inherit pkgs lib; };
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
  # Use user provided uuid or fallback to random one
  effectiveUuid = if uuid != null then uuid else libVirt.mkUuid name;

  # Normalize parameters using helpers
  normalizedMemory = libVirt.normalizeMemory memory;
  normalizedVcpu = libVirt.normalizeVcpu vcpu;

  # Host system detection
  hostOS = libVirt.getHostOS system;
  hostArch = libVirt.getHostArch system;

  # Hypervisor and machine type selection
  effectiveHypervisorType = libVirt.getHypervisorType hostOS hostArch arch;
  effectiveMachineType = libVirt.getMachineType machineType arch;

  effectiveEmulatorPath = "${pkgs.qemu}/bin/qemu-system-${arch}";
in
{
  # TODO: Consider assert if exceeding limits
  # RAM, vCPU cores,
  inherit name;
  memory = normalizedMemory;
  vcpu = normalizedVcpu;

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
    disk = libVirt.mkDisks disks;
  };
}
