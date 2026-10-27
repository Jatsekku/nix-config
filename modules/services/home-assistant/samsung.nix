{
  den.aspects.services.home-assistant.samsung = {
    nixos = {
      services.home-assistant = {
        extraComponents = [
          "smartthings"
        ];
      };
    };
  };
}
