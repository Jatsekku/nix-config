{
  den.aspects.utils.radeontop = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.radeontop
      ];
    };
  };
}
