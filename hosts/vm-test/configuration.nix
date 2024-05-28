{config, lib, pkgs, ...}: {
    imports = [
        ../../common/base
        ../../common/hyprland.nix

        ../../disko/disko_zfs_singleSSD.nix

        ../../users/jatsekku

        ./networking.nix
        ./hardware-configuration.nix
    ];
    
    boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;

    system.stateVersion = "23.11";
}
