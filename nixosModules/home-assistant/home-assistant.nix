{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixOS.home-assistant;
in
{
  options.myNixOS.home-assistant = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Home Asistant service";
    };
  };

  config = lib.mkIf cfg.enable {
    services.home-assistant = {
      enable = true;
      extraComponents = [
        "default_config"
        # Components required to complete the onboarding
        "esphome"
        "met"
        "radio_browser"
        "mqtt"
      ];
      config = {
        # Includes dependencies for a basic setup
        # https://www.home-assistant.io/integrations/default_config/
        default_config = { };
        scene = "!include scenes.yaml";
      };
    };

    networking.firewall.allowedTCPPorts = [ 8123 ];
  };
}
