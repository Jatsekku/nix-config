{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      myLib = import ./myLib/default.nix { inherit inputs; };
    in
    {
      nixosConfigurations =
        {
        };

      # Configure nix fmt
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;

      nixosModules.default = ./nixosModules;
    };
}
