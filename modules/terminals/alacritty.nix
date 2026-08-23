{
  den.aspects.terminals.alacritty = {
    nixos = { pkgs, ... }: {
      # Install alacritty
      environment.systemPackages = [ pkgs.alacritty ];
    };
  };
}
