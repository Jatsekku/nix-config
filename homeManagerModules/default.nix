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
    ./git.nix
    ./fzf.nix
    ./obsidian.nix
    ./vscodium.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };

  myHomeManager = {
    git.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    obsidian.enable = lib.mkDefault false;
    vscodium.enable = lib.mkDefault false;
  };
}
