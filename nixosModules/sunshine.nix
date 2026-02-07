{
  lib,
  config,
  ...
}:

with lib;

let
  cfg = config.myNixOS.sunshine;
in
{
  options.myNixOS.sunshine = {
    enable = mkEnableOption "Sunshine";
    autoStart = mkOption {
      type = lib.types.bool;
      default = false;
      description = "Autostart Sunshine";
    };
  };

  config = mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      inherit (cfg) autoStart;
      #capSysAdmin = true;
      openFirewall = true;
    };
  };
}
