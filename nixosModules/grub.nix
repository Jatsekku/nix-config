{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixOS.grub;
in
{
  options.myNixOS.grub = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable grub bootloader";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.loader = {
      # Use GRUB 2 as bootloader
      grub.enable = true;

      # Build GRUB with EFI support
      grub.efiSupport = true;

      # Allow modifing EFI boot variables
      efi.canTouchEfiVariables = true;

      # Do not install grub on any device
      grub.device = "nodev";
    };
  };
}
