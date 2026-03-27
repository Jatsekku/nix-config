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

    withAshell = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable (not foricng) ashell";
    };

    withHypridle = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable (not foricng) hypridle";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      # Enable Hyprland itself
      enable = true;
      # Enable XWaylad support
      xwayland.enable = true;
      # Enable UWSM support
      withUWSM = true;
    };

    myNixOS.ashell.enable = lib.mkDefault cfg.withAshell;

    # Enable hypridle service
    services.hypridle.enable = cfg.withHypridle;
  };
}
