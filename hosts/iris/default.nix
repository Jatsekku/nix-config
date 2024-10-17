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

  networking.hostName = "iris";
  networking.hostId = "0F0F0F02";
  system.stateVersion = "23.11";
}
