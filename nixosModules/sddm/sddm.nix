{
  config,
  lib,
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
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      theme = "${import ./themes/sddm-sugar-dark.nix { inherit pkgs; }}";
      wayland.enable = true;
    };

    # Needed for SDDM theming
    environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects
    ];
  };
}
