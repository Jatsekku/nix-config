{ inputs, ... }:
{
  den.aspects.virtualization.nix-vm = {
    nixos = {
      imports = [ inputs.nix-vm.nixosModules.default ];
    };
  };
}
