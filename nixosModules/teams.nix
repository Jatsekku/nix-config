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
    enable = mkEnableOption "Microsoft Teams";
  };

  config = lib.mkIf cfg.enable {
    # Add Microsoft Teams package
    environment.systemPackages = [ pkgs.teams-for-linux ];
  };
}
