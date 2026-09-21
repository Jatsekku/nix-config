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
