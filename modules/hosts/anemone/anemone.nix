{
  den,
  ...
}:
{
  den.aspects.anemone = {
    includes = with den.aspects; [
      desktop.niri
      desktop.plasma
      desktop.sddm

      editors.nixvim

      (system.disko ./_disko.nix)
      (system.facter ./_facter.json)
      system.git
      system.grub
      system.locale
      system.networkmanager
      system.nh
      system.nix

      utils.fzf

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
