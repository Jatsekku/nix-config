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
    vscodium.enable = lib.mkEnableOption "Enable vscodium";
  };

  config = lib.mkIf config.myHomeManager.vscodium.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
    };
  };
}
