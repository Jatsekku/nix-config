{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixOS.mosquitto;
in
{
  options.myNixOS.mosquitto = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable mosquitto service";
    };
  };

  config = lib.mkIf cfg.enable {
    services.mosquitto = {
      enable = true;
      listeners = [
        {
          acl = [ "pattern readwrite #" ];
          omitPasswordAuth = true;
          settings.allow_anonymous = true;
        }
      ];
    };

    networking.firewall.allowedTCPPorts = [ 1883 ];
  };
}
