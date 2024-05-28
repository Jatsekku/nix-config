{ pkgs, ... }:

{
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
