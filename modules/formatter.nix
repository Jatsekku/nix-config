{ inputs, ... }: {
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem = { config, pkgs, ... }: {
    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
        nixfmt.enable = true;
      };
    };
  };
}
