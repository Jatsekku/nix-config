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
  imports = [
    ./lualine.nix
    ./neo-tree.nix
    ./telescope.nix
    ./treesitter.nix
  ];
}
