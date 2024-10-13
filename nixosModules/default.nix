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
    inputs.home-manager.nixosModules.default
    inputs.hyprland.nixosModules.default
    ./grub.nix
    ./home-manager.nix
    ./hyprland
    ./nh.nix
    ./nix.nix
    ./virtualization
  ];

  myNixOS = {
    grub.enable = lib.mkDefault true;
    home-manager.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    nh.enable = lib.mkDefault true;
    docker.enable = lib.mkDefault false;
  };
}
