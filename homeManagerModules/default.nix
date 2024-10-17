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
    ./obsidian.nix
    ./vscodium.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };

  myHomeManager = {
    fzf.enable = lib.mkDefault true;
    obsidian.enable = lib.mkDefault false;
    vscodium.enable = lib.mkDefault false;
  };
}
