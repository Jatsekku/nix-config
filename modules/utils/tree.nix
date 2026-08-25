{
  den.aspects.utils.tree = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        # Depth intended directory listing utility
        pkgs.tree
      ];
    };
  };
}
