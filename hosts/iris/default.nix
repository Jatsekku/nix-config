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
    ./hyprland
  ];

  programs.bash-logger = {
    enable = true;
    createEtcSymlink = true;
  };
  facter.reportPath = ./facter.json;
  services.getty.autologinUser = "nari";

  myNixOS = {
    chromium.enable = true;
    kodi = {
      enable = true;
      withNetflix = true;
      withYoutube = true;
    };
    openssh.enable = true;
    mosquitto.enable = true;
    moonlight.enable = true;
    netbootxyz = {
      #enable = true;
      liveEndpoint = "http://192.168.0.140:8080";
      winBaseUrl = "http://192.168.0.140:8080/WinPE";
      sambaShare.enable = true;
      dhcpProxy = true;
    };
    home-assistant = {
      enable = true;
      zigbee.useZ2M = true;
      zigbee.adapterPort = "/dev/serial/by-id/usb-ITead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_a8fe3a457245ed118bfec68f0a86e0b4-if00-port0";
      wyoming.enable = true;
    };
    samba = {
      #enable = true;
      wsdd = true;
    };
    sddm.enable = false;
    wake-on-lan = {
      # Enable waking this machine via WoL on en01
      asTarget = {
        enable = true;
        interfaces = [ "en01" ];
      };

      # Allow sending WoL packets from this machine
      asSource.enable = true;
    };
    waypipe.enable = true;
    wayvnc.enable = true;
    wyoming = {
      whisper.enable = true;
    };
    zsh.enable = true;
  };

  # JUST FOR TESTING!
  services.openssh.settings = {
    PasswordAuthentication = true;
  };

  networking.hostName = "iris";
  networking.hostId = "0F0F0F02";
  system.stateVersion = "23.11";
}
