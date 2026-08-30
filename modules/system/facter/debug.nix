{ inputs, ... }:
{
  den.aspects.system.facter-debug = {
    nixos = {
      imports = [ inputs.nixos-facter-debug.nixosModules.default ];

      # Do not set nixpkgs.hostPlatform
      disabledModules = [ "hardware/facter/system.nix" ];

      hardware.facter-debug.enable = true;
    };
  };
}
