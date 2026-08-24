{ inputs, lib, ... }:
{
  den.aspects.editors.nixvim = {
    nixos = {
      imports = [ inputs.nixvim.nixosModules.nixvim ];

      programs.nixvim = {
        enable = true;
        viAlias = lib.mkDefault true;
        vimAlias = lib.mkDefault true;

        opts = {
          expandtab = lib.mkDefault true;
          tabstop = lib.mkDefault 4;
          shiftwidth = lib.mkDefault 4;
        };
      };
    };
  };
}
