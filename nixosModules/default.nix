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
    ./grub.nix
  ];

  myNixOS = {
    grub.enable = lib.mkDefault true;
  };
}
