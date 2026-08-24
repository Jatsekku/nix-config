{
  den.aspects.system.networkmanager = {
    nixos = {
      networking.networkmanager = {
        enable = true;

        # BUG (24.08.2026):
        # There is problem with NM/iwd integration
        # when SSID contains characters like "@" or "+".
        #wifi.backend = "iwd";
        wifi.backend = "wpa_supplicant";
      };
    };
  };
}
