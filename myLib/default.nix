{ inputs }:
let
  myLib = (import ./default.nix) { inherit inputs; };
  outputs = inputs.self.outputs;
in
rec {
  /**
    Build system confgiuration

    # Type

    ```
    mkSystem :: { config :: String; hostName :: String} -> AttrSet
    ```
  */
  mkSystem =
    { config, hostName }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit
          inputs
          outputs
          myLib
          hostName
          ;
      };
      modules = [
        config
        outputs.nixosModules.default
      ];
    };
}
