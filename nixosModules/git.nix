{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.git;
in
{
  options.myNixOS.git = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable git module";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add git package
    environment.systemPackages = [ pkgs.git ];
  };
}
