{ inputs, lib, ... }:
{
  den.aspects.editors.nixvim = {
    nixos = {
      imports = [ inputs.nixvim.nixosModules.nixvim ];

      programs.nixvim = {
        enable = true;
        viAlias = lib.mkDefault true;
        vimAlias = lib.mkDefault true;

        # Set colorscheme
        colorschemes.catppuccin = {
          enable = true;
          settings = {
            flavour = "mocha";
          };
        };

        # Force nixvim to use system provided nixpkgs
        nixpkgs.source = inputs.nixpkgs;

        opts = {
          # Wait up to 300ms for another stroke
          timeoutlen = 300;
          # Show line number
          number = true;
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
