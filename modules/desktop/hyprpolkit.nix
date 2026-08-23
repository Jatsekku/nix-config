{ lib, ... }:
{
  den.aspects.desktop.hyprpolkit = {
    nixos = { pkgs, ... }: {
      # Enable polkit
      security.polkit.enable = lib.mkDefault true;

      # Install hyprpolkit
      environment.systemPackages = [ pkgs.hyprpolkitagent ];

      # Create systemd service
      systemd.user.services.hyprpolkitagent = {
        description = "Hyprpolkitagent Authentication Daemon";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];

        # Do not run for self-managed DE
        unitConfig = {
          ConditionEnvironment = [
            "!XDG_CURRENT_DESKTOP=GNOME"
            "!XDG_CURRENT_DESKTOP=KDE"
            "!XDG_CURRENT_DESKTOP=XFCE"
            "!XDG_CURRENT_DESKTOP=Cinnamon"
            "!XDG_CURRENT_DESKTOP=MATE"
            "!XDG_CURRENT_DESKTOP=LXQt"
          ];
        };

        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
          Restart = "on-failure";
          RestartSec = 1;
        };
      };
    };
  };
}
