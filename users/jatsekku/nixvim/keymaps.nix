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
    ];
  };
}
