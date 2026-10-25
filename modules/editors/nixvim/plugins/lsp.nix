{
  den.aspects.editors.nixvim = {
    nixos = {
      programs.nixvim = {
        plugins.lsp = {
          enable = true;

          servers = {
            # Bash
            bashls.enable = true;
            # C/C++
            clangd.enable = true;
            # CMake
            cmake.enable = true;
            # Nix
            nil_ls.enable = true;
            nixd.enable = true;
            # Markdown
            marksman.enable = true;
            # Python
            pyright.enable = true;
            # YAML
            yamlls.enable = true;
            # Rust
            rust_analyzer = {
              enable = true;
              installCargo = true;
              installRustc = true;
            };
          };

          keymaps = {
            lspBuf = {
              # Show doc pop-up [LSP]
              "K" = "hover";

              # Code action [LSP]
              "<leader>ca" = "code_action";
              # Format buffer [LSP]
              "<leader>f" = "format";
              # Go to definition [LSP]
              "<leader>gd" = "definition";
              # Go to references [LSP]
              "<leader>gr" = "references";
              # Safely rename symbol [LSP]
              "<leader>rn" = "rename";
            };

            diagnostic = {
              # Show error/warnning pop-up [LSP]
              "<leader>e" = "open_float";
            };
          };
        };
      };
    };
  };
}
