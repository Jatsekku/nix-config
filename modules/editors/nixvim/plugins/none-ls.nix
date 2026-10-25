{
  den.aspects.editors.nixvim = {
    nixos = {
      programs.nixvim = {
        plugins.none-ls = {
          enable = true;

          sources = {
            diagnostics = {
              statix.enable = true;
            };

            formatting = {
              nixfmt.enable = true;
              shellharden.enable = true;
              shfmt.enable = true;
            };
          };
        };
      };
    };
  };
}
