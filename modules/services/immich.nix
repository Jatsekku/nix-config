{
  den.aspects.services.immich = {
    nixos = {
      services.immich = {
        # Enable Immich service (Google Photos clone)
        enable = true;
        port = 2283;
        openFirewall = true;
        host = "0.0.0.0";
      };
    };
  };
}
