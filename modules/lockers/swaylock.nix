{
  den.aspects.lockers.swaylock = {
    nixos = { pkgs, ... }: {
      # Install swaylock
      environment.systemPackages = [ pkgs.swaylock ];
    };
  };
}
