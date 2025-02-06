{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.sddm;
in
{
  options.myNixOS.sddm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable SDDM";
    };
    sessionType = lib.mkOption {
      type = lib.types.enum [
        "x11"
        "wayland"
      ];
      default = "wayland";
      description = "Choose between X11 or Wayland for SDDM";
    };
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      theme = "${import ./themes/sddm-sugar-dark.nix { inherit pkgs; }}";
      # Apply only if wayland has been requested
      wayland.enable = cfg.sessionType == "wayland";
    };

    # Needed for SDDM theming
    environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects
    ];
  };
}
