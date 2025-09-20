{ config, ... }:
{
  services.uwsm-launcher = {
    enable = true;
    username = "nari";
    compositor-name = "hyprland";
    compositor-launcher = "hyprland-uwsm.desktop";
  };

  services.monitor-detector = {
    enable = true;
    rules = [
      {
        event = "attached";
        pattern = "*Optoma UHD*";
        callback = "${config.services.uwsm-launcher.exe-start}";
      }
      {
        event = "detached";
        pattern = "*Optoma UHD*";
        callback = "${config.services.uwsm-launcher.exe-stop}";
      }
    ];
  };
}
