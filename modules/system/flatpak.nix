{ inputs, ... }:
{
  den.aspects.system.flatpak = {
    nixos = {
      imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];

      services.flatpak.enable = true;
    };

    homeManaager = {
      imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];
    };
  };
}
