{ pkgs, ... }:

{
  imports = [
    ../../home/hyprland.nix
    ../../home/waybar.nix
    ../../home/kicad.nix
    ../../home/kitty.nix
    ../../home/wofi.nix
    ../../home/vscodium.nix
    ../../home/virt-manager.nix
    ../../home/fzf.nix
    ../../home/obsidian.nix
  ];

  home.username = "jatsekku";
  home.homeDirectory = "/home/jatsekku";
  home.stateVersion = "23.11";

  # User-level packages
  home.packages = with pkgs; [
    chromium
  ];

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
