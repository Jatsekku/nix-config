{
  den.aspects.notificators.mako = {
    nixos = { pkgs, ... }: {
      # Install mako
      environment.systemPackages = [ pkgs.mako ];
    };
  };
}
