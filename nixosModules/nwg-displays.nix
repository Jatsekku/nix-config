{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.myNixOS.nwg-displays;
in
{
  options.myNixOS.nwg-displays = {
    enable = lib.mkEnableOption "nwg-displays (Output management utility for Sway and Hyprland)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nwg-displays
    ];
  };
}
