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
    ./nixvim
    ./hyprland.nix
    ./vscode.nix
  ];

  home.stateVersion = "23.11";

  myHomeManager = {
    git = {
      enable = true;
      lfs = true;
    };
    fzf.enable = true;
    obsidian.enable = true;
    vscode.enable = true;
    zsh = {
      enable = true;
      useAsDefault = true;
    };
    user-ssh-autokeygen.enable = true;
    udiskie.enable = true;
    zellij.enable = true;
  };
}
