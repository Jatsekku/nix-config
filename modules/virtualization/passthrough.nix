{ inputs, ... }:
{
  den.aspects.virtualization.passthrough = {
    nixos = {
      imports = [ inputs.gpu-passthrough.nixosModules.default ];
      hardware.pciPassthrough = {
        enable = true;
        devicesLists."my-set" = {
          devices = [
            {
              address = "0000:0d:00.1";
              id = "1002:ab28";
            }
            {
              address = "0000:0d:00.0";
              id = "1002:73ff";
            }
          ];
          bindOnBoot = true;
        };
      };
    };
  };
}
