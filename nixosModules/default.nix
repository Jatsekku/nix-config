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
    ./nix.nix
  ];

  myNixOS = {
    grub.enable = lib.mkDefault true;
  };
}
