{
  den.aspects.editors.nixvim = {
    nixos = {
      programs.nixvim.plugins.treesitter = {
        enable = true;
      };
    };
  };
}
