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
    ./fzf.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };

  myHomeManager = {
    fzf.enable = lib.mkDefault true;
  };
}
