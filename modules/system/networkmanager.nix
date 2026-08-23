{
  den.aspects.system.networkmanager = {
    nixos = {
      networking.networkmanager = {
        enable = true;
        wifi.backend = "iwd";
      };
    };
  };
}
