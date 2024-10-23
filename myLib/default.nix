{ inputs }:
let
  myLib = (import ./default.nix) { inherit inputs; };
  outputs = inputs.self.outputs;
in
rec {
  /**
    Get list of usernames at given hostname from list defined in form of homeConfgiurations:

    # Example

    ```nix
    homeConfgiurations = {
      "jatsekku@anemone" = {};
      "jatsekku@iris" = {};
      "ewe@iris" = {};
    };
    getUsersForHost {
      hostname = "iris";
      usersAtHosts = homeConfgiurations;
    };
    =>
    [ "ewe" "jatsekku" ]
    ```

    # Type

    ```
    getUsersForHost :: { hostname :: String; userAtHosts :: AttrSet} -> [String]
    ```
  */
  getUsersForHost =
    {
      # Hostanme for which usernames will be retruned
      hostName,
      # Attribute set with "username@host" strings that will be processed
      usersAtHosts,
    }:
    let
      homeUsersAtHosts = builtins.attrNames (usersAtHosts);
      isAssociated = userAtHost: builtins.elemAt (builtins.split "@" userAtHost) 2 == hostName;
      username = userAtHost: builtins.elemAt (builtins.split "@" userAtHost) 0;
      filtered = builtins.filter isAssociated homeUsersAtHosts;
    in
    (builtins.map username filtered);

  /**
    Build systems configuration

    # Type

    ```
    mkSystem :: { config :: String; hostName :: String} -> AttrSet
    ```
  */
  mkSystem =
    { config, hostName }:
    let
      usersAtHosts = outputs.homeConfigurations;
      usernames = myLib.getUsersForHost {
        inherit hostName;
        inherit usersAtHosts;
      };
      usersConfigs = {
        users.users = (
          builtins.listToAttrs (
            builtins.map (username: {
              name = username;
              value = myLib.userManagerToNixOS { inherit username hostName; };
            }) usernames
          )
        );
      };
    in
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
        usersConfigs
        config
        outputs.nixosModules.default
      ];
    };

  /**
    Build systems configurations

    # Type

    ```
    mkSystemsConfigurations :: AttrSet -> AttrSet
    ```
  */
  mkSystemsConfigurations =
    configurations:
    builtins.mapAttrs (
      hostName: config:
      myLib.mkSystem {
        inherit config;
        inherit hostName;
      }
    ) configurations;

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

  /**
    Translate homeManager AttrSet to nixOS AttrSet
  */
  userManagerToNixOS =
    { hostName, username }:
    outputs.homeConfigurations."${username}@${hostName}".config.myUserManager.${username};

}
