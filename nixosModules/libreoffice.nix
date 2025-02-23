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
  cfg = config.myNixOS.libreoffice;
in
{
  options.myNixOS.libreoffice = {
    enable = lib.mkEnableOption "LibreOffice";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libreoffice-qt
      hunspell
    ];
  };
}
