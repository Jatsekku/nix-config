{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../../common/base
    ../../common/graphics.nix
    ../../common/hyprland.nix
    ../../common/sddm.nix
    ../../common/gaming.nix
    ../../common/virtualization.nix
    ../../common/polkit.nix
    ../../common/act.nix
    ../../common/docker.nix
    ../../common/nh.nix
    ../../disko/disko_zfs_singleSSD.nix

    ../../users/jatsekku

    ./networking.nix
    ./hardware-configuration.nix
  ];

  #boot.kernelPackages = linuxPackages_6_6;
  nixpkgs.config.allowUnfree = true;

  # Enable graphic card driver for X and Wayland
  services.xserver.videoDrivers = [ "amdgpu" ];

  system.stateVersion = "23.11";
}
