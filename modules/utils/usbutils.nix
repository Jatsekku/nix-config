{
  den.aspects.utils.usbutils = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.usbutils
      ];
    };
  };
}
