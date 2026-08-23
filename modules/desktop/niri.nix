{ den, lib, ... }:
let
  # TODO: Change to actual condition that checks if niri config haas been provided
  hasExternalConfig = false;
in
{
  den.aspects.desktop.niri = {
    includes =
      with den.aspects;
      [
        desktop.hyprpolkit
      ]
      ++ lib.optionals (!hasExternalConfig) [
        terminals.alacritty
        launchers.fuzzel
        lockers.swaylock
        notificators.mako
      ];

    nixos = { pkgs, ... }: {
      # Enble Niri (Wayland compositor)
      programs.niri.enable = true;

      # Install gnome-keyring + configure PAM auto-unlock
      services.gnome.gnome-keyring.enable = lib.mkDefault true;

      # Cross-desktop API for apps
      xdg.portal = {
        enable = lib.mkDefault true;
        extraPortals = with pkgs; [
          # Required for most of basic functionality
          xdg-desktop-portal-gtk
          # Required for screencasting
          xdg-desktop-portal-gnome
        ];
      };

      # Required for X11 apps
      environment.systemPackages = [ pkgs.xwayland-satellite ];
    };
  };
}
