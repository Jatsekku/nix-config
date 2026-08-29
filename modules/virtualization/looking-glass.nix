{ inputs, ... }:
{
  den.aspects.virtualization.looking-glass = displays: {
    nixos = {
      imports = [ inputs.gpu-passthrough.nixosModules.looking-glass ];

      virtualisation.looking-glass = {
        enable = true;
        enableClient = true;
        inherit displays;
      };
    };
  };
}
