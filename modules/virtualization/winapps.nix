{ inputs, ... }:
{
  den.aspects.virtualization.winapps = {
    nixos =
      { pkgs, ... }:
      let
        winapps-pkgs = inputs.winapps.packages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        environment.systemPackages = with winapps-pkgs; [
          winapps
          winapps-launcher
        ];

        # Set up binary cache
        nix.settings = {
          substituters = [ "https://winapps.cachix.org/" ];
          trusted-public-keys = [ "winapps.cachix.org-1:HI82jWrXZsQRar/PChgIx1unmuEsiQMQq+zt05CD36g=" ];
        };
      };
  };
}
