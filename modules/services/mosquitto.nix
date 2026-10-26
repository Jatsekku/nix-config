let
  port = 1883;
in
{
  den.aspects.services.mosquitto = {
    nixos = {
      services.mosquitto = {
        enable = true;
        listeners = [
          {
            inherit port;
            acl = [ "pattern readwrite #" ];
            settings.allow_anonymous = true;
          }
        ];
      };

      networking.firewall.allowedTCPPorts = [ port ];
    };
  };
}
