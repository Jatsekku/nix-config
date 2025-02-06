{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.waypipe;
in
{
  options.myNixOS.waypipe = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable waypipe";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add waypipe package
    environment.systemPackages = [ pkgs.waypipe ];
  };
}
