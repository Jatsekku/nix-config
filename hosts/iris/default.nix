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
    home-asistant.enable = true;
  };

  # JUST FOR TESTING!
  services.openssh.settings = {
    PasswordAuthentication = true;
  };

  networking.hostName = "iris";
  networking.hostId = "0F0F0F02";
  system.stateVersion = "23.11";
}
