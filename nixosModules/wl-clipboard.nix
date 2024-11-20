{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.wl-clipboard;
in
{
  options.myNixOS.wl-clipboard = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable wl-clipboard";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add wl-clipboard package
    environment.systemPackages = [ pkgs.wl-clipboard ];
  };
}
