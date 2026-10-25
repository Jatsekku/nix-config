{
  den.aspects.editors.nixvim = {
    nixos = {
      programs.nixvim = {
        plugins.lualine = {
          enable = true;
        };
      };
    };
  };
}
