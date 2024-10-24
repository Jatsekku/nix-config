{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.chromium;
in
{
  options.myNixOS.chromium = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable chromium";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add chromium package
    environment.systemPackages = [ pkgs.chromium ];
  };
}
