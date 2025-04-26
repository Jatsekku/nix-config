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
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      telescope-ui-select-nvim
    ];

    plugins.telescope = {
      enable = true;

      extensions.fzf-native.enable = true;

      enabledExtensions = [
        "ui-select"
      ];
    };
  };
}
