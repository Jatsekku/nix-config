{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  ...
}:
{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
  ];

  myNixOS = {
    openssh.enable = true;
    home-assistant = {
      enable = true;
      zigbee.useZ2M = true;
      zigbee.adapterPort = "/dev/serial/by-id/usb-ITead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_a8fe3a457245ed118bfec68f0a86e0b4-if00-port0";
    };
  };

  # JUST FOR TESTING!
  services.openssh.settings = {
    PasswordAuthentication = true;
  };

  networking.hostName = "iris";
  networking.hostId = "0F0F0F02";
  system.stateVersion = "23.11";
}
