{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.myNixOS.zoom-us;
in
{
  options.myNixOS.zoom-us = {
    enable = mkEnableOption "Zoom";
  };

  config = lib.mkIf cfg.enable {
    programs.zoom-us.enable = true;
  };
}
