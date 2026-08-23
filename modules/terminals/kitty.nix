{
  den.aspects.terminals.kitty = {
    nixos = { pkgs, ... }: {
      # Install kitty terminal
      environment.systemPackages = [ pkgs.kitty ];
    };
  };
}
