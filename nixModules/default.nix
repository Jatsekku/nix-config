{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./grub.nix
    ./nix.nix
  ];

  myNixOS = {
    grub.enable = lib.mkDefault true;
  };
}
