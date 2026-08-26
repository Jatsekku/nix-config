{
  den.aspects.services.immich = {
    nixos = {
      services.immich = {
        # Enable Immich service (Google Photos clone)
        enable = true;
        port = 2283;
      };
    };
  };
}
