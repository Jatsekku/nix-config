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
    which-key.enable = true;
  };
}
