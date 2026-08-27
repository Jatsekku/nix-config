{ lib, ... }:
let
  # TODO: Change to actual condition once you decided how to manage it
  isHostGraphical = true;
in
{
  den.aspects.virtualization.libvirtd = {
    nixos = { pkgs, ... }: {
      virtualisation.libvirtd = {
        enable = true;
      };

      environment.systemPackages = lib.optionals isHostGraphical (with pkgs; [ virt-manager ]);
    };
  };
}
