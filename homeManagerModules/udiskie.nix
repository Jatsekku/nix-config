{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  username,
  ...
}:
let
  cfg = config.myHomeManager.udiskie;
in
{
  options.myHomeManager.udiskie = {
    enable = lib.mkEnableOption "udiskie";
  };

  config = lib.mkIf cfg.enable {
    services.udiskie = {
      enable = true;
      automount = true;
    };
  };
}
