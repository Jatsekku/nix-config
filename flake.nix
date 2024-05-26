{
    description = "NixOS config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs"; 
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
        home-manager
    }: {
        nixosConfigurations = {
            vm-test = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";

                modules = [
                    home-manager.nixosModules.home-manager
                    ./hosts/vm-test/configuration.nix
                    disko.nixosModules.disko
                ];

            };
        };
    };
}
