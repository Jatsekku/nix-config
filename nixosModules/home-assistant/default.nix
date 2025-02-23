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
  imports = [
    ./home-assistant.nix
    ./wyoming.nix
    ./zigbee.nix
  ];
}
