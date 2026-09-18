{
  den.aspects.cad.klayout = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        # Layout viewer and editor with GDS and OASIS support
        pkgs.klayout
      ];
    };
  };
}
