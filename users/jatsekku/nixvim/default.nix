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
    ./options.nix
    ./plugins
  ];
}
