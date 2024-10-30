{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.polkit;
in
{
  options.myNixOS.polkit = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable polkit";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add polkit package
    environment.systemPackages = [ pkgs.polkit ];
  };
}
