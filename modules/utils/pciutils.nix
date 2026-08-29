{
  den.aspects.utils.pciutils = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.pciutils
      ];
    };
  };
}
