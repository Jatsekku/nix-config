{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.myNixOS.ashell;
in
{
  options.myNixOS.ashell = {
    enable = lib.mkEnableOption "Ashell - Status Bar for hyprland";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ashell
    ];
  };
}
