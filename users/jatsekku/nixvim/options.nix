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
  programs.nixvim = {
    opts = {
      autoindent = true;
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
    };
  };
}
