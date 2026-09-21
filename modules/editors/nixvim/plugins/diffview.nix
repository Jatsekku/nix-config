{
  den.aspects.editors.nixvim = {
    nixos = {
      programs.nixvim = {

        plugins.diffview = {
          enable = true;
        };

        keymaps = [
          {
            mode = "n";
            key = "<leader>dv";
            action = "<cmd>DiffviewOpen<CR>";
            options.desc = "Open Diffview [Diffview]";
          }
          {
            mode = "n";
            key = "<leader>dh";
            action = "<cmd>DiffviewFileHistory<CR>";
            options.desc = "Open Repo History [Diffview]";
          }
          {
            mode = "n";
            key = "<leader>dc";
            action = "<cmd>DiffviewClose<CR>";
            options.desc = "Close Diffview [Diffview]";
          }
        ];
      };
    };
  };
}
