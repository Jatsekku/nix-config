{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.calibre;
in
{
  options.myNixOS.calibre = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable calibre";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add calibre package
    environment.systemPackages = [ pkgs.calibre ];
  };
}
