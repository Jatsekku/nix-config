{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      myLib = import ./myLib/default.nix { inherit inputs; };
    in
    {
      nixosConfigurations = myLib.mkSystemsConfigurations {
        anemone = ./hosts/anemone;
      };

      # Configure nix fmt
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

      nixosModules.default = ./nixosModules;
      homeManagerModules.default = ./homeManagerModules;
      userManager.default = ./userManager;
    };
}
