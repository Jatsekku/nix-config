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
    ./kitty.nix
    ./obsidian.nix
    ./vscodium.nix
    ./wofi.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };

  myHomeManager = {
    git.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    kitty.enable = lib.mkDefault false;
    obsidian.enable = lib.mkDefault false;
    vscodium.enable = lib.mkDefault false;
    wofi.enable = lib.mkDefault false;
  };
}
