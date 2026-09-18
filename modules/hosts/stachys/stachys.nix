{
  den,
  ...
}:
{
  den.aspects.stachys = {
    includes = with den.aspects; [
      cad.kicad
      cad.klayout

      desktop.niri
      desktop.plasma
      desktop.sddm

      editors.arduino
      editors.nixvim

      gaming.moonlight
      gaming.steam

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

      web.chromium
    ];

    nixos = {
      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "uas"
        "usbhid"
        "sd_mod"
        "rtsx_pci_sdmmc"
      ];
    };
  };
}
