{
  pkgs,
  lib,
  config,
  ...
}:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium.fhs;
  };
}
