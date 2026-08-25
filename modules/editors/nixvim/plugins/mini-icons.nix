{ lib, ... }:
let
  # TODO: Change to actual condition once you decided how to manage it
  isHostGraphical = true;
in
{
  den.aspects.editors.nixvim = {
    nixos = { pkgs, lib, ... }: {
      # Icon provider
      programs.nixvim = { lib, ... }: {
        plugins.mini = {
          enable = true;
          modules.icons = {
            # Inject Lua logic to dynamically fallback to ascii on TTY
            style = lib.nixvim.mkRaw ''vim.env.TERM == "linux" and "ascii" or "glyph"'';
          };
          mockDevIcons = true;
        };
      };

      # Install icons from Nerd Fonts if host is graphical
      fonts.packages = lib.mkIf isHostGraphical [
        pkgs.nerd-fonts.symbols-only
      ];
    };
  };
}
