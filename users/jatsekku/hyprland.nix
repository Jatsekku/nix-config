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
  myHomeManager = {
    kitty.enable = true;
    wofi.enable = true;
  };

  wayland.windowManager.hyprland =
    let
      # Modifier key
      mod = "SUPER";
      modshift = "${mod}SHIFT";
      # Default terminal for hyprland session
      terminal = "kitty";
      # Open program launcher
      menu = "wofi --show drun";

    in
    {
      enable = true;
      settings = {

        # Monitors config
        monitor = [
          # 1 Screen: 
          # "DP-4" -> Display port #4, 
          # "1920x1080@60 -> Resolution: 1920 x 1080, Refreshing 60Hz
          # "0x0" -> Postion (x,y) : 0,0
          # "1" -> No scaling 
          "DP-4,1920x1080@60,0x0,1"

          # 2 Screen: 
          # "DP-4" -> Display port #4, 
          # "1920x1080@60 -> Resolution: 1920 x 1080, Refreshing 60Hz
          # "0x0" -> Postion (x,y) : 0,0
          # "1" -> No scaling
          # "transform,2" -> Rotation 180 degrees
          "DP-5,1920x1080@60,1920x0,1,transform,2"
        ];

        input = {
          kb_layout = "pl";
        };

        # Key bindings
        bind = [
          # Open terminal
          "${mod}, T, exec, ${terminal}"

          # Open program launcher
          "${mod}, P, exec, ${menu}"

          # Windows managmenet
          # Close active window
          "${mod}, C, killactive"

          # Window resizing
          "${mod}, M, fullscreen, 1"

          # Workspace managmenet
          # Cycle focus between windows on single screen
          "${mod}, Tab, cyclenext"

          # Cycle between workspaces
          "${mod}, H, workspace, -1"
          "${mod}, L, workspace, +1"

          # Move windows between workspaces
          "${modshift}, 1, movetoworkspace, 1"
          "${modshift}, 2, movetoworkspace, 2"
          "${modshift}, 3, movetoworkspace, 3"
          "${modshift}, 4, movetoworkspace, 4"
          "${modshift}, 5, movetoworkspace, 5"
        ];

        decoration = {
          rounding = 5;
        };
      };
    };
}
