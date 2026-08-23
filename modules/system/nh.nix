{ inputs, ... }:
{
  den.aspects.system.nh = {
    nixos.programs.nh = {
      enable = true;

      # Enable periodic GC oon weekly basis
      # Keep last 5 generations
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 5";
      };
    };
  };
}
