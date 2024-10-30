{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.grim;
in
{
  options.myNixOS.grim = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable grim";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add grim package
    environment.systemPackages = [ pkgs.grim ];
  };
}
