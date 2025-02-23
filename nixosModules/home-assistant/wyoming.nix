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
  cfg = config.myNixOS.home-assistant.wyoming;
in
{
  options.myNixOS.home-assistant.wyoming = {
    enable = lib.mkEnableOption "Wyoming integration for home-assistant";
  };

  config = lib.mkIf cfg.enable {
    # Add wyoming integraton
    services.home-assistant.extraComponents = [ "wyoming" ];
  };
}
