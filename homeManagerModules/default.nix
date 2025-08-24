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
    ./nixvim.nix
    ./obsidian.nix
    ./vscode.nix
    ./udiskie.nix
    ./wofi.nix
    ./zellij.nix
    ./zsh.nix
  ];

  myHomeManager = {
    git.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    kitty.enable = lib.mkDefault false;
    nixvim.enable = lib.mkDefault true;
    obsidian.enable = lib.mkDefault false;
    vscode.enable = lib.mkDefault false;
    wofi.enable = lib.mkDefault false;
  };
}
