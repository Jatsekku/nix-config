{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.myNixOS.gpu-screen-recorder;
in
{
  options.myNixOS.gpu-screen-recorder = {
    enable = mkEnableOption "gpu-screen-recorder";
  };

  config = lib.mkIf cfg.enable {
    # Add gpu-screen-recorder package
    environment.systemPackages = [
      pkgs.gpu-screen-recorder
    ];
  };
}
