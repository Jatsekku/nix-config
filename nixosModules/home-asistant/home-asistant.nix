{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  hostName,
  ...
}:
{
  options.myNixOS = {
    home-asistant.enable = lib.mkEnableOption "Enable home-asistant";
  };

  config = lib.mkIf config.myNixOS.home-asistant.enable {
    services.home-assistant = {
      enable = true;
      extraComponents = [
        # Components required to complete the onboarding
        "esphome"
        "met"
        "radio_browser"
      ];
      config = {
        # Includes dependencies for a basic setup
        # https://www.home-assistant.io/integrations/default_config/
        default_config = { };
      };
    };

    networking.firewall.allowedTCPPorts = [ 8123 ];
  };
}