{ den, ... }:
let
  adapter = "zstack";
  device = "/dev/serial/by-id/usb-ITead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_a8fe3a457245ed118bfec68f0a86e0b4-if00-port0";
  webPort = 8080;
  server = "mqtt://localhost:1883";
in
{
  den.aspects.services.zigbee2mqtt = {
    includes = [
      den.aspects.services.mosquitto
    ];
    nixos = {
      services.zigbee2mqtt = {
        enable = true;
        settings = {
          mqtt = {
            inherit server;
            base_topic = "zigbee2mqtt";
          };

          serial = {
            inherit adapter;
            port = device;
          };

          frontend = {
            port = webPort;
            host = "0.0.0.0";
          };
        };
      };

      networking.firewall.allowedTCPPorts = [ webPort ];
    };
  };
}
