{
  den.aspects.system.grub = {
    nixos = {
      boot.loader = {
        # Allow modifing EFI boot variables
        efi.canTouchEfiVariables = true;

        grub = {
          # Use GRUB 2 as bootloader
          enable = true;
          # Enable EFI support
          efiSupport = true;
          # Do not install grub on any device
          device = "nodev";
          # Autodetect other systems
          useOSProber = true;
        };

      };
    };
  };
}
