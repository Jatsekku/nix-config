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
  # Enable web-devicons
  programs.nixvim.plugins = {
    web-devicons.enable = true;
  };
}
