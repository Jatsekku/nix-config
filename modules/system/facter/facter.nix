{ lib, ... }:
{
  den.aspects.system.facter = reportPath: {
    nixos =
      { pkgs, ... }:
      {
        # Always bring CLI tools with the aspect.
        # It simplifies generting report on fresh machines
        environment.systemPackages = [ pkgs.nixos-facter ];
      }
      // lib.optionalAttrs (builtins.pathExists reportPath) {
        # Facter engine should be brought only if there is report to handle
        hardware.facter = {
          inherit reportPath;
          enable = true;
          # Usully managed by network managers
          detected.dhcp.enable = lib.mkDefault false;
        };
      };
  };
}
