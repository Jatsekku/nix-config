{
  den.aspects.math.octave = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.octaveFull
      ];
    };
  };
}
