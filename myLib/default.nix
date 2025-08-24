{ inputs }:
rec {
  mkSystem =
    {
      hostname,
      config,
      platform,
      overlays ? [ ],
      users ? { },
    }:
    let
      # User configs (system-level) for each user
      usersSystemConfigs = users |> builtins.mapAttrs (_: v: import v.user) |> builtins.attrValues;

      # Users attrs where each contain home
      usersWithHome =
        users
        |> builtins.attrNames
        |> builtins.map (name: {
          inherit name;
          value = users.${name};
        })
        |> builtins.filter (user: builtins.hasAttr "home" user.value)
        |> builtins.listToAttrs;

      usersHomeManagerModules =
        usersWithHome
        |> builtins.mapAttrs (
          username: v: {
            home-manager = {
              extraSpecialArgs = { inherit username; };
              users.${username}.imports = [ v.home ];
            };
          }
        )
        |> builtins.attrValues;

    in
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs hostname; };
      modules = [
        inputs.self.nixosModules.default
        config
      ]
      ++ usersSystemConfigs
      ++ usersHomeManagerModules;
      pkgs = import inputs.nixpkgs {
        inherit overlays;
        system = platform;
        config = {
          allowUnfree = true;
        };
      };
    };

  mkSystemsConfigurations =
    configurations:
    builtins.mapAttrs (
      hostname:
      {
        config,
        platform,
        overlays ? [ ],
        users ? { },
      }:
      mkSystem {
        inherit
          hostname
          config
          platform
          overlays
          users
          ;
      }
    ) configurations;
}
