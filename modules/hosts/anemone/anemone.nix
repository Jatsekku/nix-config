{
  den,
  ...
}:
{
  den.aspects.anemone = {
    includes = with den.aspects; [
      ai.claude

      cad.kicad
      cad.klayout

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
      system.flatpak
      system.git
      system.grub
      system.locale
      system.networkmanager
      system.nh
      system.nix

      utils.fzf
      utils.pciutils
      utils.simple-scan
      utils.smart
      utils.tree
      utils.ydotool

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

      vms.osmia

      web.chromium
    ];

    nixos = {
      environment.sessionVariables = {
        KWIN_DRM_DEVICES = "/dev/dri/by-path/pci-0000\\\\:05\\\\:00.0-card";
      };

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
