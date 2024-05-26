{ pkgs, ... }:

{
    home.username = "test";
    home.homeDirectory = "/home/test";
    home.stateVersion = "23.11";

    # Let home Manager install and manage itself.
    programs.home-manager.enable = true;
}
