{
  den.aspects.services.home-assistant.bluetooth = {
    nixos = {
      services.home-assistant = {
        extraComponents = [
          "bluetooth"
          "bluetooth_adapters"
          "bluetooth_le_tracker"
        ];
      };
    };
  };
}
