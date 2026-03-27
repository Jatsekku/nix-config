{
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
let
  cfg = config.myHomeManager.ashell;

  commands = {
    bluetoothMore = osConfig.myNixOS.bluetooth-manager.guiCmd;
    wifiMore = osConfig.myNixOS.network-manager.guiCmd;
    shutdown = "shutdown now";
    reboot = "systemctl reboot";
    logout = "uwsm stop"; # WM dependent - move to wm-manger later
  };
in
{
  options.myHomeManager.ashell = {
    enable = lib.mkEnableOption "Enable ashell";
  };

  config = lib.mkIf cfg.enable {
    programs.ashell = {
      enable = true;
      systemd.enable = true;

      settings.settings = {
        "bluetooth_more_cmd" = commands.bluetoothMore;
        "wifi_more_cmd" = commands.wifiMore;
        "shutdown_cmd" = commands.shutdown;
        "reboot_cmd" = commands.reboot;
        "logout_cmd" = commands.logout;
      };
    };
  };
}
