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
{
  imports = [
    ./colorschemes.nix
    ./keymaps.nix
    ./plugins
  ];
}
