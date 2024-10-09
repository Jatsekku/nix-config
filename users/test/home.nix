{ pkgs, ... }:

{
  home.username = "test";
  home.homeDirectory = "/home/test";
  home.stateVersion = "23.11";

  # User-level packages
  home.packages = with pkgs; [
    chromium
  ];

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
