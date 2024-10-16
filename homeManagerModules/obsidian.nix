{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  ...
}:
{
  options.myHomeManager = {
    obsidian.enable = lib.mkEnableOption "Enable obsidian";
  };

  config = lib.mkIf config.myHomeManager.obsidian.enable {
    home.packages = [ pkgs.obsidian ];
  };
}
