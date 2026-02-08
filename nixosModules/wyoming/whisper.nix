{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixOS.wyoming.whisper;
in

with lib;
{
  options.myNixOS.wyoming.whisper = {
    enable = mkEnableOption "Wyoming Whisper service";
  };

  config = lib.mkIf cfg.enable {
    services.wyoming.faster-whisper = {
      servers = {
        default = {
          enable = true;
          model = "base-int8";
          language = "en";
          uri = "tcp://0.0.0.0:10300";
          device = "auto";
        };
      };
    };

    networking.firewall.allowedTCPPorts = [ 10300 ];
  };
}
