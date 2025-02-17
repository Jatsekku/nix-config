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
  # Enable nvim-lspconfig
  programs.nixvim.plugins = {
    lsp = {
      enable = true;

      servers = {
        bashls.enable = true;
        clangd.enable = true;
        nil_ls.enable = true;
        rust-analyzer.enable = true;
      };
    };
  };
}
