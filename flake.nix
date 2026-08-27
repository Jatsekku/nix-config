{
  description = "Jatsekku's NixOS flake file. (Dendritic pattern with Den framework)";

  inputs = {
    # Aspect-oriented, context-driven Nix configurations.
    den.url = "github:denful/den";

    # Declarative disk partitioning and formatting using Nix.
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Simplify Nix Flakes with the module system.
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Manage a user environment using Nix.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Import all nix files in a directory tree.
    import-tree.url = "github:denful/import-tree";

    # Nix Packages collection & NixOS.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Configure Neovim with Nix.
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # LibVirt domain management for Nix.
    nixvirt = {
      url = "github:AshleyYakeley/NixVirt";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # The formatter multiplexer
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
