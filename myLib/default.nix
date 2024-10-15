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

  mkHome =
    { username, platform }:
    let
      config = ../users/${username};
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${platform};
      extraSpecialArgs = {
        inherit
          inputs
          outputs
          myLib
          username
          ;
      };
      modules = [
        config
        outputs.homeManagerModules.default
      ];
    };
}
