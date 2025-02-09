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
  programs.nixvim.plugins.telescope = {
    enable = true;

    extensions.fzf-native.enable = true;
  };
}
