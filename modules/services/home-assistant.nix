{
  den.aspects.services.home-assistant = {
    nixos = { config, lib, ... }: {
      services.home-assistant = {
        # Enable service
        enable = true;

        extraComponents = [
          # Components required to complete the onboarding
          "analytics"
          "google_translate"
          "met"
          "radio_browser"
          "shopping_list"
          # Recommended for fast zlib compression
          # https://www.home-assistant.io/integrations/isal
          "isal"
        ];

        config = {
          # Includes dependencies for a basic setup
          # https://www.home-assistant.io/integrations/default_config/
          default_config = { };
          http = {
            server_port = lib.mkDefault 8123;
          };
        };
      };

      # Open required port
      networking.firewall.allowedTCPPorts = [
        config.services.home-assistant.config.http.server_port
      ];
    };

  };
}
