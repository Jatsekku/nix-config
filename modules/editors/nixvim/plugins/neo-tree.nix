{
  den.aspects.editors.nixvim = {
    nixos = {
      # Filesystem (and others) treeview navigator
      programs.nixvim.plugins.neo-tree = {
        enable = true;
      };
    };
  };
}
