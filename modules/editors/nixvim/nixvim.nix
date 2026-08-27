{ inputs, lib, ... }:
{
  den.aspects.editors.nixvim = {
    nixos = {
      imports = [ inputs.nixvim.nixosModules.nixvim ];

      programs.nixvim = {
        enable = true;
        viAlias = lib.mkDefault true;
        vimAlias = lib.mkDefault true;

        # Force nixvim to use system provided nixpkgs
        nixpkgs.source = inputs.nixpkgs;

        opts = {
          expandtab = lib.mkDefault true;
          tabstop = lib.mkDefault 4;
          shiftwidth = lib.mkDefault 4;
        };

        # Set default leader key
        globals.mapleader = lib.mkDefault " ";
      };
    };
  };
}
