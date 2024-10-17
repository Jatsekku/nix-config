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
    vscode.enable = lib.mkEnableOption "Enable vscode";
  };

  config = lib.mkIf config.myHomeManager.vscode.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
    };
  };
}
