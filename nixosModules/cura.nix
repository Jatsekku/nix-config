{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.myNixOS.cura;
in
{
  options.myNixOS.cura = {
    enable = lib.mkEnableOption "Cura Slicer";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cura-appimage
    ];
  };
}
