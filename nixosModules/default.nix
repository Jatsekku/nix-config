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
    ./chromium.nix
    ./git.nix
    ./grub.nix
    ./home-manager.nix
    ./hyprland
    ./kitty.nix
    ./nh.nix
    ./nix.nix
    ./virtualization
    ./wofi.nix
  ];

  myNixOS = {
    chromium.enable = lib.mkDefault false;
    git.enable = lib.mkDefault true;
    grub.enable = lib.mkDefault true;
    home-manager.enable = lib.mkDefault true;
    hyprland.enable = lib.mkDefault true;
    kitty.enable = lib.mkDefault false;
    nh.enable = lib.mkDefault true;
    docker.enable = lib.mkDefault false;
    wofi.enable = lib.mkDefault false;
  };
}
