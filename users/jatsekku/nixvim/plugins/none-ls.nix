{
  # Enable nvim-lspconfig
  programs.nixvim.plugins.none-ls = {
    enable = true;
    sources = {
      diagnostics = {
        # Nix lang linter
        statix.enable = true;
      };
      formatting = {
        nixfmt.enable = true;
        shellharden.enable = true;
        shfmt.enable = true;
      };
    };
  };
}
