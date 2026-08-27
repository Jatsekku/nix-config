{
  den.aspects.editors.nixvim = {
    nixos = { pkgs, ... }: {
      programs.nixvim = {

        extraPackages = with pkgs; [
          # Required for live grep
          ripgrep
        ];

        plugins.telescope = {
          enable = true;

          # Default keymapping
          keymaps = {
            "<leader>ff" = {
              action = "find_files";
              options.desc = "Find file [Telescope]";
            };
            "<leader>fg" = {
              action = "live_grep";
              options.desc = "Live grep [Telescope]";
            };
            "<leader>fb" = {
              action = "buffers";
              options.desc = "Find buffers [Telescope]";
            };
          };
        };
      };
    };
  };
}
