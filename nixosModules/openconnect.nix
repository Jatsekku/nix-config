{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.openconnect;
in
{
  options.myNixOS.openconnect = {
    enable = lib.mkEnableOption "Openconnect (VPN client)";
  };

  config = lib.mkIf cfg.enable {
    # Install openconnect
    environment.systemPackages = [
      pkgs.openconnect
    ];
  };
}
