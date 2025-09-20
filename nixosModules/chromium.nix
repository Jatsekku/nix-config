{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.chromium;
in
{
  options.myNixOS.chromium = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable chromium";
    };
    withWidevine = lib.mkEnableOption "Widevine support in chromium";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (
        if cfg.withWidevine then
          pkgs.chromium.override {
            enableWideVine = true;
          }
        else
          pkgs.chromium
      )
    ];
  };
}
