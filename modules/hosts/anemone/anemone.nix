{
  den,
  ...
}:
{
  den.aspects.anemone = {
    includes = with den.aspects; [
      (system.disko ./_disko.nix)
      (system.facter ./_facter.json)
      system.grub
      system.nh
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
