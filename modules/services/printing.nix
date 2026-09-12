let
  # TODO: Change to actual condition once you decided how to manage it
  isHostGraphical = true;
in
{
  den.aspects.services.printing = {
    nixos = { pkgs, ... }: {
      services = {
        # Auto-discovery of network printers
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };

        # CUPS
        printing = {
          enable = true;
          drivers = with pkgs; [
            # Driver for Brother laser printers
            brlaser
          ];
        };

      };
      # GUI for CUPS
      programs.system-config-printer.enable = isHostGraphical;
    };
  };
}
