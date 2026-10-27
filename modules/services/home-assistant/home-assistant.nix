{ den, ... }: {
  den.aspects.services.home-assistant = {
    includes = [
      den.aspects.services.home-assistant.lights
      den.aspects.services.home-assistant.roborock
      den.aspects.services.home-assistant.voice
      den.aspects.services.home-assistant.xiaomi
    ];

    nixos = { config, lib, ... }: {
      services.home-assistant = {
        # Enable service
        enable = true;
        # Do not allow edit from HA's web interface
        configWritable = false;

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

          light = [
            {
              platform = "group";
              name = "Kitchen Ceiling Lights";
              entities = [
                "light.kitchenceilinglight_1"
                "light.kitchenceilinglight_2"
                "light.kitchenceilinglight_3"
                "light.kitchenceilinglight_4"
                "light.kitchenceilinglight_5"
                "light.kitchenceilinglight_6"
              ];
            }
            {
              platform = "group";
              name = "Salon Ceiling Lights";
              entities = [
                "light.salonceilinglight_1"
                "light.salonceilinglight_2"
                "light.salonceilinglight_3"
                "light.salonceilinglight_4"
                "light.salonceilinglight_5"
                "light.salonceilinglight_6"
              ];
            }
          ];
        };
      };

      # Open required port
      networking.firewall.allowedTCPPorts = [
        config.services.home-assistant.config.http.server_port
      ];
    };

  };
}
