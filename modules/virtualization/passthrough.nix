{ inputs, ... }:
{
  den.aspects.virtualization.passthrough = devicesLists: {
    nixos = {
      imports = [ inputs.gpu-passthrough.nixosModules.default ];

      hardware.pci-passthrough = {
        enable = true;
        inherit devicesLists;
      };
    };
  };
}
