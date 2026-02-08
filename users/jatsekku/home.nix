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
    ./ashell.nix
    ./nixvim
    ./hyprland.nix
    ./vscode.nix
  ];

  home.stateVersion = "23.11";

  myHomeManager = {
    ashell.enable = true;
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
    notification-daemon.mako.enable = true;
    user-ssh-autokeygen.enable = true;
    user-ssh-to-age.enable = true;
    udiskie.enable = true;
    zellij.enable = true;
  };
}
