{ pkgs, ... }:

{
    programs.hyprland = {
        # Enable hyprland
        enable = true;
        xwayland.enable = true;
    };
}