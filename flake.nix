{
    description = "NixOS config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs"; 
        };

        impermanence = {
            url = "github:nix-community/impermanence";
        };
    
        disko = {
            url = "github:nix-community/disko/";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        disko,
        impermanence,
        home-manager
    }: {
        nixosConfigurations = {
            vm-test = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";

                modules = [
                    home-manager.nixosModules.home-manager
                    impermanence.nixosModules.impermanence
                    ./hosts/vm-test/configuration.nix
                    disko.nixosModules.disko
                ];

            };
            anemone = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";

                modules = [
                    home-manager.nixosModules.home-manager
                    impermanence.nixosModules.impermanence
                    ./hosts/anemone/configuration.nix
                    disko.nixosModules.disko
                ];

            };
        };
    };
}
