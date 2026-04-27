{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.myNixOS.wf-recorder;
in
{
  options.myNixOS.wf-recorder = {
    enable = mkEnableOption "wf-recorder";
  };

  config = lib.mkIf cfg.enable {
    # Add wf-recorder package
    environment.systemPackages = [
      pkgs.wf-recorder
    ];
  };
}
