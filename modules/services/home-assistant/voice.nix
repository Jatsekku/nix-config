{
  den.aspects.services.home-assistant.voice = {
    nixos = {
      services.home-assistant = {
        extraComponents = [
          "assist_pipeline"
          "conversation"
          "intent"
        ];

        config = {
          conversation = { };
        };
      };
    };
  };
}
