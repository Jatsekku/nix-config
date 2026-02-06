{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.bottles;
in
{
  options.myNixOS.bottles = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable bottles module";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add bottles package
    environment.systemPackages = [ pkgs.bottles ];
  };
}
