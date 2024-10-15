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
  home = {
    stateVersion = "23.11";
  };

  myHomeManager = {
    fzf.enable = true;
  };
}
