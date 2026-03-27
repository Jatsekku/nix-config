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
    ./gnome-disk.nix
    ./gnome-power-manager.nix
  ];
}
