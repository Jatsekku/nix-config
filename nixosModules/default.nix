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
    ./grub.nix
  ];

  myNixOS = {
    grub.enable = lib.mkDefault true;
  };
}
