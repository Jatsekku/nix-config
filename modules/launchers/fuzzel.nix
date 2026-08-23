{
  den.aspects.launchers.fuzzel = {
    nixos = { pkgs, ... }: {
      # Install fuzzel
      environment.systemPackages = [ pkgs.fuzzel ];
    };
  };
}
