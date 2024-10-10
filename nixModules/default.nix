{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./grub.nix
    ./nh.nix
    ./nix.nix
  ];

  myNixOS = {
    grub.enable = lib.mkDefault true;
    nh.enable = lib.mkDefault true;
  };
}
