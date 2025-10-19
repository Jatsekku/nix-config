{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.myNixOS.kdenlive;
in
{
  options.myNixOS.kdenlive = {
    enable = lib.mkEnableOption "kdenlive";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.kdePackages.kdenlive
    ];
  };
}
