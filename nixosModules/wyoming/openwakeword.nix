{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixOS.wyoming.openwakeword;
in

with lib;
{
  options.myNixOS.wyoming.openwakeword = {
    enable = mkEnableOption "Wyoming OpenWakeWord service";
  };

  config = lib.mkIf cfg.enable {
    services.wyoming.openwakeword = {
      enable = true;
      uri = "tcp://0.0.0.0:10400";
    };

    networking.firewall.allowedTCPPorts = [ 10300 ];
  };
}
