{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.slurp;
in
{
  options.myNixOS.slurp = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable slurp";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add slurp package
    environment.systemPackages = [ pkgs.slurp ];
  };
}
