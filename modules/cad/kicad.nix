{
  den.aspects.cad.kicad = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        # Open source EDA
        pkgs.kicad
      ];
    };
  };
}
