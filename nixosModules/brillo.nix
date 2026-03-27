{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.brillo;
in
{
  options.myNixOS.brillo = {
    enable = lib.mkEnableOption "Brillo (Backlight and Keyboard LED control tool)";
  };

  config = lib.mkIf cfg.enable {
    # Add brillo package and load it's udev rules
    hardware.brillo.enable = true;
  };
}
