{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.myNixOS.moonlight;
in
{
  options.myNixOS.moonlight = {
    enable = lib.mkEnableOption "Moonlight (Sunshine client)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      moonlight-qt
    ];
  };
}
