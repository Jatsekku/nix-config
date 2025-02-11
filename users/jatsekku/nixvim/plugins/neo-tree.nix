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
  programs.nixvim.plugins.neo-tree = {
    enable = true;
  };
}
