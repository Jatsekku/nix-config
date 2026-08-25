{
  den.aspects.utils.fzf = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        # CLI fuzzy finder
        pkgs.fzf
      ];
    };
  };
}
