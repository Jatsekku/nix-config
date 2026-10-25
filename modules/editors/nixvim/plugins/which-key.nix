{
  den.aspects.editors.nixvim = {
    nixos = {
      programs.nixvim = {
        plugins.which-key = {
          enable = true;
        };
      };
    };
  };
}
