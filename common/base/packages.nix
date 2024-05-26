{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        curl
        git
        neofetch
        neovim
        wget
    ];
}
