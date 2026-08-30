{
  den,
  ...
}:
{
  den.aspects.anemone = {
    includes = with den.aspects; [
      cad.kicad

      desktop.niri
      desktop.plasma
      desktop.sddm

      editors.arduino
      editors.nixvim

      gaming.moonlight
      gaming.steam
      gaming.sunshine

      services.home-assistant
      services.immich

      shells.zsh

      (system.disko ./_disko.nix)
      (system.facter ./_facter.json)
      system.facter-debug
      system.git
      system.grub
      system.locale
      system.networkmanager
      system.nh
      system.nix

      utils.fzf
      utils.pciutils
      utils.smart
      utils.tree

      virtualization.libvirtd
      (virtualization.nixvirt.windows10 {
        name = "win10-workstation";
        disks = {
          path = "/dev/disk/by-id/nvme-WD_BLACK_SN850X_1000GB_24122X800837";
          serial = "24122X800837";
        };
      })
      (virtualization.nixvirt.linux {
        name = "alpine";
        disks = "/home/jatsekku/Downloads/alpine-standard-3.24.1-x86_64.iso";
      })
      virtualization.passthrough

      web.chromium
    ];

    nixos = {
      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
    };
  };
}
