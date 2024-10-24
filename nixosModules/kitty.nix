{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.kitty;
in
{
  options.myNixOS.kitty = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable kitty";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add kitty package
    environment.systemPackages = [ pkgs.kitty ];
  };
}
