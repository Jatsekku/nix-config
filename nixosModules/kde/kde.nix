{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixOS.kde;
in
{
  options.myNixOS.kde = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable KDE Plasma";
    };
  };

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
