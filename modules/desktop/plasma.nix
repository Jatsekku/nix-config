{
  den.aspects.desktop.plasma = {
    nixos = {
      services = {
        # Enable KDE Plasma 6 desktop environment
        desktopManager.plasma6.enable = true;
      };
    };
  };
}
