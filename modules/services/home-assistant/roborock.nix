{
  den.aspects.services.home-assistant.roborock = {
    nixos = {
      services.home-assistant = {
        extraComponents = [
          "roborock"
        ];
      };
    };
  };
}
