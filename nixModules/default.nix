{
  pkgs,
  lib,
  config,
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
