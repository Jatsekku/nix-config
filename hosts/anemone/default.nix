{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "anemone";
  networking.hostId = "0F0F0F01";
  system.stateVersion = "23.11";
}
