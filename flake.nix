{
  description = "NixOS config flake";

  inputs = {
    bash-logger = {
      url = "github:Jatsekku/bash-logger";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    docker-xdg-open = {
      url = "github:Jatsekku/docker-xdg-open";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    monitor-detector.url = "github:Jatsekku/monitor-detector";
    uwsm-launcher.url = "github:Jatsekku/uwsm-launcher";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    gpu-passthrough = {
      url = "github:Jatsekku/gpu-passthrough";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    libvirt-hooks = {
      url = "github:Jatsekku/libvirt-hooks";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvirt = {
      url = "github:AshleyYakeley/NixVirt";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      myLib = import ./myLib/default.nix { inherit inputs; };
    in
    {

      nixosConfigurations = myLib.mkSystemsConfigurations {
        anemone = {
          config = ./hosts/anemone;
          platform = "x86_64-linux";
          users = {
            jatsekku = {
              user = ./users/jatsekku/user.nix;
              home = ./users/jatsekku/home.nix;
            };
          };
        };

        artemisia = {
          config = ./hosts/artemisia;
          platform = "x86_64-linux";
          users = {
            jatsekku = {
              user = ./users/jatsekku/user.nix;
              home = ./users/jatsekku/home.nix;
            };
          };
        };

        iris = {
          config = ./hosts/iris;
          platform = "x86_64-linux";
          users = {
            jatsekku = {
              user = ./users/jatsekku/user.nix;
            };
            nari = {
              user = ./users/nari-bot/user.nix;
            };
          };
        };
      };

      vmConfigurations = {
        win10-hwa = ./hosts/vms/win10-hwa;
      };

      # Configure nix fmt
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

      nixosModules.default = ./nixosModules;
      homeManagerModules.default = ./homeManagerModules;
    };
}
