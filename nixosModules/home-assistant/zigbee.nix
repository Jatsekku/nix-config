{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixOS.home-assistant.zigbee;
  ha-enabled = config.services.home-assistant.enable;
in
{
  options.myNixOS.home-assistant.zigbee = {
    useZHA = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable ZHA support for home-assistant";
    };
    useZ2M = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Z2M support for home-assistant";
    };
    adapterPort = lib.mkOption {
      type = lib.types.str;
      default = "/dev/ttyUSB0";
    };
  };

  config = lib.mkIf ha-enabled (
    lib.mkMerge [
      (lib.mkIf cfg.useZHA {
        # ZHA component for HA
        services.home-assistant = {
          extraComponents = [
            "zha"
          ];
        };
      })

      (lib.mkIf cfg.useZ2M {
        services.zigbee2mqtt = {
          enable = true;
          settings = {
            #homeassistant = true;
            serial = {
              adapter = "zstack";
              port = cfg.adapterPort;
            };
            permit_join = true;
            mqtt = {
              server = "mqtt://localhost";
              user = "zigbee2mqtt";
              password = "test";
            };
          };
        };
      })
    ]
  );
}
