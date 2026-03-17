{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.myHomeManager.hyprpaper;
in
{
  options.myHomeManager.hyprpaper = {
    enable = lib.mkEnableOption "Enable hyprpaper";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprpaper = {
      enable = true;
    };
  };
}
