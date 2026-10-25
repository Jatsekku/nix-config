{
  den.aspects.editors.nixvim = {
    nixos = {
      programs.nixvim = {
        plugins = {
          # Filesystem (and others) treeview navigator
          neo-tree = {
            enable = true;
          };
        };

        keymaps = [
          {
            mode = "n";
            key = "<leader>t";
            action = ":Neotree toggle<cr>";
            options.desc = "Toggle file-tree [neo-tree]";
          }
        ];
      };
    };
  };
}
