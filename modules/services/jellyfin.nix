{
  den.aspects.services.jellyfin = {
    nixos = {
      services.jellyfin = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
