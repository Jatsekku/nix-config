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
  cfg = config.myHomeManager.zellij;
in
{
  options.myHomeManager.zellij = {
    enable = lib.mkEnableOption "Zellij";
  };

  config = lib.mkIf cfg.enable {
    programs.zellij.enable = true;
  };
}
