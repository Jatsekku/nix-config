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
    ./vscode.nix
    ./wofi.nix
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };

  myHomeManager = {
    fzf.enable = lib.mkDefault true;
    obsidian.enable = lib.mkDefault false;
    vscode.enable = lib.mkDefault false;
    wofi.enable = lib.mkDefault false;
  };
}
