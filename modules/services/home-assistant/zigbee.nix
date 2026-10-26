{ den, lib, ... }: {
  den.aspects.services.home-assistant.zigbee = {
    includes = [
      den.aspects.services.zigbee2mqtt
    ];

    nixos = {
      services.zigbee2mqtt.settings = {
        homeassistant = lib.mkForce true;
      };

      services.home-assistant = {
        extraComponents = [ "mqtt" ];
      };
    };
  };
}
