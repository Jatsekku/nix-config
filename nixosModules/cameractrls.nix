{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.myNixOS.teams;
in
{
  options.myNixOS.teams = {
    enable = mkEnableOption "Cameractrls";
  };

  config = lib.mkIf cfg.enable {
    # Add cameractrls package
    environment.systemPackages = [ pkgs.cameractrls ];
  };
}
