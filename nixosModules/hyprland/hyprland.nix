{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixOS.hyprland;
in
{
  options.myNixOS.hyprland = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable hyprland";
    };

    hostSettings = lib.mkOption {
      type = lib.types.attrs;
      default = { };
      description = "Host specific settings for hyprland";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      # Enable Hyprland itself
      enable = true;
      # Enable XWaylad support
      xwayland.enable = true;
    };
  };
}
