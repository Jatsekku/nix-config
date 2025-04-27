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
let
  mkKeyMap = mode: key: action: desc: {
    inherit mode key;
    options.desc = desc;
    action = "<cmd>" + "${action}" + "<cr>";
  };
in
{
  programs.nixvim = {
    globals.mapleader = " ";

    keymaps = [
      (mkKeyMap "n" "<leader>ff" "Telescope find_files" "Find file (Telescope)")
      (mkKeyMap "n" "<leader>fg" "Telescope live_grep" "Live grep (Telescope)")

      (mkKeyMap "n" "<leader>t" "Neotree toggle" "Toggle file-tree (Neotree)")

      (mkKeyMap "n" "<leader>?" "WhichKey" "Show keymaps binding (which-key)")

      {
        action = ":lua vim.lsp.buf.code_action()<cr>";
        key = "<leader>ca";
        options = {
          silent = true;
          noremap = true;
          desc = "Select code action";
        };
      }
      {
        action = ":lua vim.lsp.buf.definition()<cr>";
        key = "<leader>gd";
        options = {
          silent = true;
          noremap = true;
          desc = "Go to symbol definition (LSP)";
        };
      }
      {
        action = ":lua vim.lsp.buf.hover()<cr>";
        key = "K";
        options = {
          silent = true;
          noremap = true;
          desc = "Display symbol information (LSP)";
        };
      }
      {
        action = ":lua vim.lsp.buf.references()<cr>";
        key = "<leader>gr";
        options = {
          silent = true;
          noremap = true;
          desc = "Go to symbol references (LSP)";
        };
      }
      {
        action = ":lua vim.lsp.buf.format()<cr>";
        key = "<leader>gf";
        options = {
          silent = true;
          noremap = true;
          desc = "Format buffer (LSP)";
        };
      }
    ];
  };
}
