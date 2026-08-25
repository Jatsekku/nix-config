{ lib, ... }: {
  den.aspects.gaming.sunshine = {
    nixos = {
      services.sunshine = {
        # Enable Sunshine service
        enable = true;
        # Do not start on boot
        autoStart = lib.mkDefault false;
        # Open required ports
        openFirewall = lib.mkDefault true;
      };

      # Virtual input devices support
      hardware.uinput.enable = lib.mkDefault true;
    };
  };
}
