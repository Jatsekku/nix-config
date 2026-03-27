{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.bluetooth-manager.blueman;
in
{
  options.myNixOS.bluetooth-manager.blueman = {
    enable = lib.mkEnableOption "Blueman (Bluetooth Manager)";

    guiCmd = lib.mkOption {
      type = lib.types.str;
      default = "blueman-manager";
      description = "Coommand to run GUI for Blueman";
      readOnly = true;
    };
  };

  config = lib.mkIf cfg.enable {
    services.blueman.enable = true;
  };
}
