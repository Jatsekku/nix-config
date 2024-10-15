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

  /**
    Build home confgiuration

    # Type

    ```
    mkHome :: { config :: String; userName :: String, platform :: String} -> AttrSet
    ```
  */
  mkHome =
    {
      config,
      username,
      platform,
    }:
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
        outputs.userManager.default
      ];
    };
}
