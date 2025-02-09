{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.ripgrep;
in
{
  options.myNixOS.ripgrep = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable ripgrep";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add chromium package
    environment.systemPackages = [ pkgs.ripgrep ];
  };
}
