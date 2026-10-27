{ den, ... }: {
  den.aspects.services.home-assistant.xiaomi = {
    includes = [
      den.aspects.services.home-assistant.bluetooth
    ];

    nixos = { pkgs, ... }: {
      services.home-assistant = {
        extraComponents = [
          "xiaomi_ble"

          # Needed by xiaomi_miot
          "ffmpeg"
          "homekit"
        ];
        customComponents = [
          pkgs.home-assistant-custom-components.xiaomi_miot

          (pkgs.buildHomeAssistantComponent rec {
            owner = "perseus177";
            domain = "mikettle_ble";
            version = "v1.2.1";

            src = pkgs.fetchFromGitHub {
              inherit owner;
              rev = version;
              repo = "ha-xiaomi-kettle-ble";
              hash = "sha256-9R4HA3fm9jEie3JixIIL94vnuy3Nw8v00knm2QBjaZE=";
            };
          })
        ];
      };
    };
  };
}
