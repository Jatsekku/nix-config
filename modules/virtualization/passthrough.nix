{ inputs, ... }:
{
  den.aspects.virtualization.passthrough = devicesLists: {
    nixos = {
      imports = [ inputs.gpu-passthrough.nixosModules.default ];

      hardware.pciPassthrough = {
        enable = true;
        inherit devicesLists;
      };
    };
  };
}
