{ den, ... }:
{
  den.aspects.artemisia = {
    includes = with den.aspects; [
      desktop.plasma
      desktop.sddm

      editors.nixvim

      (system.disko ./_disko.nix)

      system.git
      system.locale
      system.networkmanager
      system.nh
      system.nix

      web.chromium
    ];

    nixos = {
      boot = {
        initrd.availableKernelModules = [
          "usb_storage"
          "uas"
          "ahci"
          "xhci_pci"
          "nvme"
          "btrfs"
          "dm_crypt"
        ];

        loader.grub = {
          device = "nodev";
          enable = true;
          efiInstallAsRemovable = true;
          efiSupport = true;
          useOSProber = true;

          enableCryptodisk = true;

          mirroredBoots = [
            {
              devices = [ "nodev" ];
              path = "/boot";
            }
          ];
        };
      };
    };
  };
}
