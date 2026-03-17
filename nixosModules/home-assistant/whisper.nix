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
  cfg = config.myNixOS.home-assistant.whisper;
in
{
  options.myNixOS.home-assistant.whisper = {
    enable = lib.mkEnableOption "Whisper integration for home-assistant";
  };

  config = lib.mkIf cfg.enable {
    # Add whisper integraton
    services.home-assistant.extraComponents = [ "whisper" ];
  };
}
