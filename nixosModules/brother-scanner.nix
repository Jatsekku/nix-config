{
  pkgs,
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.myNixOS.brother-scanner;
in
{
  options.myNixOS.brother-scanner = {
    enable = lib.mkEnableOption "Brother scanner support";
    netDevices = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Network-connected scanners";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      # Frontend
      pkgs.simple-scan

      # Backend
      pkgs.brscan4
    ];

    hardware.sane = {
      enable = true;
      brscan4 = {
        enable = true;
        netDevices = cfg.netDevices;
      };
    };
  };
}
