{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.myNixOS.gimp;
in
{
  options.myNixOS.gimp = {
    enable = lib.mkEnableOption "GIMP (GNU Image Manipulation Program)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gimp
    ];
  };
}
