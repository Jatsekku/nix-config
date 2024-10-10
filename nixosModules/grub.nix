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
{
  options.myNixOS = {
    grub.enable = lib.mkEnableOption "Enable grub bootloader";
  };

  config = lib.mkIf config.myNixOS.grub.enable {
    boot.loader = {
      # Use GRUB 2 as bootloader
      grub.enable = true;

      # Build GRUB with EFI support
      grub.efiSupport = true;

      # Allow modifing EFI boot variables
      efi.canTouchEfiVariables = true;

      grub.device = "nodev";
    };
  };
}
