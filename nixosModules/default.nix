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
    ./virtualization
  ];

  myNixOS = {
    grub.enable = lib.mkDefault true;
    nh.enable = lib.mkDefault true;
    docker.enable = lib.mkDefault false;
  };
}
