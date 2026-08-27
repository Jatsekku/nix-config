{ lib, ... }:
let
  # TODO: Change to actual condition once you decided how to manage it
  isHostGraphical = true;
in
{
  den.aspects.utils.smart = {
    nixos = { pkgs, lib, ... }: {
      # Install smartmontools
      environment.systemPackages =
        with pkgs;
        [
          # S.M.A.R.T (disk health check) CLI utility
          smartmontools
        ]
        ++ lib.optionals isHostGraphical [
          # S.M.A.R.T (disk health check) GUI utility
          gsmartcontrol
        ];
    };
  };
}
