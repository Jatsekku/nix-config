{
  den.aspects.editors.nixvim = {
    nixos = {
      programs.nixvim = {
        plugins = {
          cmp-nvim-lsp.enable = true;
          friendly-snippets.enable = true;
          luasnip.enable = true;

          cmp = {
            enable = true;
            autoEnableSources = true;

            settings = {
              sources = [
                { name = "nvim_lsp"; }
                { name = "luasnip"; }
                { name = "buffer"; }
              ];

              mapping = {
                "<esc>" = "cmp.mapping.abort()";
                "<CR>" = "cmp.mapping.confirm({ select = true })";
                "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
                "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
              };

              window = {
                completion.__raw = "cmp.config.window.bordered()";
                documentation.__raw = "cmp.config.window.bordered()";
              };
            };
          };
        };
      };
    };
  };
}
