{
  den.aspects.services.home-assistant.bosch = {
    nixos = {
      services.home-assistant = {
        extraComponents = [
          "home_connnect"
        ];
      };
    };
  };
}
