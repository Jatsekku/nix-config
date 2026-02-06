{
  lib,
  config,
  ...
}:
let
  cfg = config.myHomeManager.notification-daemon.mako;
in
{
  options.myHomeManager.notification-daemon.mako = {
    enable = lib.mkEnableOption "Mako - notification daemon";
  };

  config = lib.mkIf cfg.enable {
    services.mako.enable = true;
  };
}
