{
  den,
  ...
}:
{
  den.aspects.anemone = {
    includes = with den.aspects; [
      ai.claude

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
      services.printing

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
      utils.ydotool

      virtualization.libvirtd
      (virtualization.nixvirt.windows10 {
        name = "win10-workstation";
        disks = [
          { path = "/home/jatsekku/Downloads/Win10_22H2_EnglishInternational_x64v1.iso"; }
          { path = "/var/lib/libvirt/images/win10-disk.qcow2"; }
        ];
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
