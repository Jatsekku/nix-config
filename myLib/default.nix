{ inputs }:
let
  myLib = (import ./default.nix) { inherit inputs; };
  outputs = inputs.self.outputs;
in
rec {
  /**
    Build systems configuration

    # Arguemnts

    config
    : Path to system config
  */
  mkSystem =
    config:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs myLib;
      };
      modules = [
        config
        outputs.nixosModules.default
      ];
    };
}
