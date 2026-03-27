{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.gnome-power-manager;
in
{
  options.myNixOS.gnome-power-manager = {
    enable = lib.mkEnableOption "gnome-power-manager";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.gnome-power-manager
    ];
  };
}
