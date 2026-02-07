{
  pkgs,
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.myNixOS.wake-on-lan;
in
{
  options.myNixOS.wake-on-lan = {
    asSource.enable = mkEnableOption "Wake-on-LAN source (this machine can send WoL packets)";

    asTarget = {
      enable = mkEnableOption "Wake-on-LAN (this machine can be woken)";

      interfaces = mkOption {
        type = types.listOf types.str;
        default = [ ];
        example = [
          "eth0"
          "enp5s0"
        ];
        description = "Network interfaces that should have Wake-on-Lan enabled.";
      };
    };
  };

  config = mkMerge [

    (mkIf cfg.asSource.enable {
      environment.systemPackages = [ pkgs.wakeonlan ];
    })

    (mkIf cfg.asTarget.enable {
      networking = {
        # Enable UDP port 9
        firewall = {
          allowedUDPPorts = [ 9 ];
        };

        # Enable WoL on specified interfaces
        interfaces =
          cfg.asTarget.interfaces
          |> (
            ifaces:
            genAttrs ifaces (_: {
              wakeOnLan.enable = true;
            })
          );
      };
    })
  ];
}
