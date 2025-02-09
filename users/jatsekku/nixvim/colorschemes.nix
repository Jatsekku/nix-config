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
  # Uncomment one of the following to apply
  programs.nixvim.colorschemes = {
    #ayu.enable = true;
    #base16.enable = true;
    #catppuccin.enable = true;
    #cyberdream.enable = true;
    #dracula-nvim.enable = true;
    #dracula.enable = true;
    #everforest.enable = true;
    #gruvbox.enable = true;
    #kanagawa.enable = true;
    #melange.enable = true;
    #modus.enable = true;
    #monokai-pro.enable = true;
    #nightfox.enable = true;
    #nord.enable = true;
    #one.enable = true;
    #onedark.enable = true;
    #oxocarbon.enable = true;
    #palette.enable = true;
    #poimandres.enable = true;
    #rose-pine.enable = true;
    #tokyonight.enable = true;
    #vscode.enable = true;
  };
}
