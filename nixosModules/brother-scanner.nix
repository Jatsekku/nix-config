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

    # brscan4 is not FOSS
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "brscan4"
        "brother-udev-rule-type1"
        "brscan4-etc-files"
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
