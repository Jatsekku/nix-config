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
    ./zigbee.nix
  ];
}
