{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  username,
  hostname,
  ...
}:
let
  hostSettings = inputs.self.nixosConfigurations.${hostname}.config.myNixOS.hyprland.hostSettings;
in
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
      settings = hostSettings // {

        workspace = [
          "1, monitor:DP-4"
        ];

        input = {
          kb_layout = "pl";
        };

        # Key bindings
        bind = [
          # Brightness up
          ", XF86MonBrightnessUp, exec, brillo -q -A 10"
          # Brightness down
          ", XF86MonBrightnessDown, exec, brillo -q -U 10"

          # Open terminal
          "${mod}, T, exec, ${terminal}"

          # Open program launcher
          "${mod}, O, exec, ${menu}"

          # Selective screenshot
          ''${mod}, S, exec, grim -g "$(slurp)" - | wl-copy''

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

          "${mod}, P, swapactiveworkspaces, 0 1"
        ];

        decoration = {
          rounding = 5;
        };
      };
    };
}
