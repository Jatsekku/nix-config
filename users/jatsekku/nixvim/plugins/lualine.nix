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
  programs.nixvim.plugins.lualine = {
    enable = true;
  };
}
