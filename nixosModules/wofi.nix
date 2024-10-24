{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.wofi;
in
{
  options.myNixOS.wofi = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable wofi";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add wofi package
    environment.systemPackages = [ pkgs.wofi ];
  };
}
