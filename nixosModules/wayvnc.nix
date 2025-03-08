{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.wayvnc;
in
{
  options.myNixOS.wayvnc = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable WayVNC";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add wayvnc
    environment.systemPackages = with pkgs; [
      wayvnc
    ];

    # Allow connection on port 5900 (VNC)
    networking.firewall.allowedTCPPorts = [ 5900 ];
  };
}
