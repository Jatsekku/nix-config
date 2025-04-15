{ inputs }:
let
  myLib = (import ./home.nix) { inherit inputs; };
  outputs = inputs.self.outputs;
in
rec {
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

  /**
    Build homes configurations

    # Type

    ```
    mkHomesConfigurations :: AttrSet -> AttrSet
    ```
  */
  mkHomesConfigurations =
    configurations:
    builtins.mapAttrs (
      userAtHost:
      { config, platform }:
      let
        username = builtins.elemAt (builtins.split "@" userAtHost) 0;
      in
      myLib.mkHome {
        inherit config username platform;
      }
    ) configurations;
}
