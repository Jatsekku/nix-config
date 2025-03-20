{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  hostName,
  ...
}:
let
  cfg = config.myNixOS.remmina;
in
{
  options.myNixOS.remmina = {
    enable = lib.mkEnableOption "Remmina (VNC client)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      remmina
    ];
  };
}
