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
      editors.gitkraken
      editors.nixvim

      gaming.moonlight
      gaming.steam
      gaming.sunshine

      math.octave

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

      (virtualization.looking-glass {
        "virtDisp0" = {
          width = 5120;
          height = 1440;
          permissions = {
            user = "jatsekku";
            group = "qemu-libvirtd";
            mode = "0660";
          };
        };
      })

      (virtualization.passthrough {
        "GPU-RX6000" = {
          devices = [
            {
              address = "0000:0d:00.1";
              id = "1002:ab28";
            }
            {
              address = "0000:0d:00.0";
              id = "1002:73ff";
            }
          ];
          bindOnBoot = true;
        };
      })

      vms.andrena
      vms.osmia

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
