{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  hostName,
  ...
}:
let
  cfg = config.myNixOS.vfio;
in
{
  options.myNixOS.vfio = {
    enable = lib.mkEnableOption "VFIO support";
    devicesID = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ ];
      example = [
        "10de:1db6"
        "10de:1aeb"
      ];
      description = "List of PCI device IDs to bind with VFIO.";
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      # Enable IOMMU
      kernelParams = [ "amd_iommu=on" ] ++ [ ("vfio-pci.ids=" + lib.concatStringsSep "," cfg.devicesID) ];

      # Load kernel modules
      initrd.kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
      ];
    };
  };
}
