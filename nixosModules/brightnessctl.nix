{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.brightnessctl;
in
{
  options.myNixOS.brightnessctl = {
    enable = lib.mkEnableOption "brightnessctl (Device Brightness Controller)";
  };

  config = lib.mkIf cfg.enable {
    # Add calibre package
    environment.systemPackages = [ pkgs.brightnessctl ];
  };
}
