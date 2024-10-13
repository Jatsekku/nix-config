{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  ...
}:
{
  options.myNixOS = {
    hyprland.enable = lib.mkEnableOption "Enable hyprland";
  };

  config = lib.mkIf config.myNixOS.hyprland.enable {
    programs.hyprland.enable = true;
  };
}
