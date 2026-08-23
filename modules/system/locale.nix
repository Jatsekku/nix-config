{
  den.aspects.system.locale = {
    nixos = { pkgs, ... }: {
      services = {
        # IP geolocation-based timezone
        automatic-timezoned.enable = true;

        # Sync clock with NTP
        timesyncd.enable = true;

        # XKB layout (essentail for Wayland/X11, safe for headless)
        xserver.xkb.layout = "pl";
      };

      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "pl_PL.UTF-8";
        LC_IDENTIFICATION = "pl_PL.UTF-8";
        LC_MEASUREMENT = "pl_PL.UTF-8";
        LC_MONETARY = "pl_PL.UTF-8";
        LC_NAME = "pl_PL.UTF-8";
        LC_NUMERIC = "pl_PL.UTF-8";
        LC_PAPER = "pl_PL.UTF-8";
        LC_TELEPHONE = "pl_PL.UTF-8";
        LC_TIME = "pl_PL.UTF-8";
      };

      # TTY/Console layut
      console.keyMap = "pl";
    };
  };
}
