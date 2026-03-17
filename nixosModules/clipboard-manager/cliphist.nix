{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.clipboard-manager.cliphist;
in
{
  options.myNixOS.clipboard-manager.cliphist = {
    enable = lib.mkEnableOption "Cliphist - Clipboard Manager";

    guiCmd = lib.mkOption {
      type = lib.types.str;
      default = "nm-connection-editor";
      description = "Coommand to run GUI for Network Manager";
      readOnly = true;
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      networkmanager
      networkmanagerapplet
    ];

    networking.networkmanager.enable = true;
  };
}
