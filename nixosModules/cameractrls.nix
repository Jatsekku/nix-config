{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.myNixOS.cameractrls;
in
{
  options.myNixOS.cameractrls = {
    enable = mkEnableOption "Cameractrls";
  };

  config = lib.mkIf cfg.enable {
    # Add cameractrls package
    environment.systemPackages = [
      pkgs.cameractrls
      pkgs.cameractrls-gtk4
    ];
  };
}
