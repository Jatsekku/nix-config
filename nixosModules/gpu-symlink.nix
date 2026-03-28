{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with types;
let
  cfg = config.hardware.gpuSymlinks;

  mkUdevRule = name: pciId: ''
    KERNEL=="card*", \
    KERNELS=="${pciId}", \
    SUBSYSTEM=="drm", \
    SUBSYSTEMS=="pci", \
    SYMLINK+="dri/${name}"
  '';

  mkUdevPkg =
    name: pciId:
    pkgs.writeTextFile {
      name = "${name}-dev-path";
      destination = "/lib/udev/rules.d/99-${name}.rules";
      text = mkUdevRule name pciId;
    };

  udevPkgs = mapAttrsToList mkUdevPkg cfg.devices;

in
{
  options.hardware.gpuSymlinks = {
    devices = mkOption {
      type = attrsOf str;
      default = { };
      example = {
        igpu = "0000:00:02.0";
        dgpu = "0000:01:00.0";
      };
    };
  };

  config = mkIf (cfg.devices != { }) {
    services.udev.packages = udevPkgs;
  };
}
