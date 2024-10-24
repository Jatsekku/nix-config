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
  };

  config = lib.mkIf (ha-enabled && cfg.useZHA) {
    # ZHA component for HA
    services.home-assistant = {
      extraComponents = [
        "zha"
      ];
    };
  };
}
