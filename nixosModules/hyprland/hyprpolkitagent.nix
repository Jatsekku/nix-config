{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.myNixOS.hyprpolkitagent;
in
{
  options.myNixOS.hyprpolkitagent = {
    enable = lib.mkEnableOption "Hyprpolkitagent (Policykit Agent for hyprland)";
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      hyprpolkitagent
    ];
  };
}
