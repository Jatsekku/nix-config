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
    inputs.disko.nixosModules.default
    ./grub.nix
    ./nh.nix
    ./nix.nix
  ];
}
