{
  den.aspects.cad.klayout = {
    nixos = { pkgs, ... }: {
      services.flatpak.packages = [
        {
          appId = "de.klayout.KLayout";
        }
      ];
    };
  };
}
