{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.loupe;
in
{
  options.myNixOS.loupe = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable loupe";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add loupe package
    environment.systemPackages = [ pkgs.loupe ];
  };
}
