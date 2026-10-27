{ den, ... }: {
  den.aspects.services.home-assistant.lights = {
    includes = [
      den.aspects.services.home-assistant.zigbee
    ];

    nixos = {
      services.zigbee2mqtt.settings = {
        devices = {
          # Kitchen
          "0xa4c1389b99ab9550".friendly_name = "kitchenCeilingLight_1";
          "0xa4c138f8cd3ddc29".friendly_name = "kitchenCeilingLight_2";
          "0xa4c138aabc954c76".friendly_name = "kitchenCeilingLight_3";
          "0xa4c13829112cd440".friendly_name = "kitchenCeilingLight_4";
          "0xa4c138428c28fe44".friendly_name = "kitchenCeilingLight_5";
          "0xa4c1382712f8631c".friendly_name = "kitchenCeilingLight_6";
          "0xa4c13830bde457ee".friendly_name = "kitchenCountertopLight";

          # Salon
          "0xa4c138955c3dfa95".friendly_name = "salonCeilingLight_1";
          "0xa4c138e9b26861c5".friendly_name = "salonCeilingLight_2";
          "0xa4c13851c5663291".friendly_name = "salonCeilingLight_3";
          "0xa4c1384e9804a824".friendly_name = "salonCeilingLight_4";
          "0xa4c138042456c387".friendly_name = "salonCeilingLight_5";
          "0xa4c138190f527958".friendly_name = "salonCeilingLight_6";
        };
      };
    };
  };
}
