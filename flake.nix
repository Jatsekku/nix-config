{
    description = "NixOS config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        disko = {
            url = "github:nix-community/disko/";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        disko,
    }: {
        nixosConfigurations = {
            vm-test = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";

                modules = [
                    ./hosts/vm-test/configuration.nix
                    disko.nixosModules.disko
                ];

            };
        };
    };
}
