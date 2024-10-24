{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  hostName,
  ...
}:
{
  options.myNixOS.home-asistant = {
    zigbee.enable = lib.mkEnableOption "Enable zigbee support for home-asistant";
  };

  config = lib.mkIf config.myNixOS.home-asistant.zigbee.enable {
    # ZHA component for HA 
    services.home-assistant = {
      extraComponents = [
        "zha"
      ];
    };

    # Enable zigbee2mqtt
    services.zigbee2mqtt = {
      enable = true;
    };

  };
}
