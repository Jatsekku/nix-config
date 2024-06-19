{config, lib, pkgs, ...}: {
    imports = [
        ../../common/base
        ../../common/graphics.nix
        ../../common/hyprland.nix
        ../../common/sddm.nix
        ../../common/gaming.nix

        ../../disko/disko_zfs_singleSSD.nix

        ../../users/jatsekku

        ./networking.nix
        ./hardware-configuration.nix
    ];
    
    boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "23.11";
}
