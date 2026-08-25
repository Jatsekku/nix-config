{ lib, ... }: {
  den.aspects.shells.zsh = {
    nixos = {
      programs.zsh = {
        enable = true;
        enableCompletion = lib.mkDefault true;
      };
    };

    homeManager = {
      programs.zsh = {
        enable = true;
        enableCompletion = lib.mkDefault true;
      };
    };
  };
}
