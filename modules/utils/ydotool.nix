{
  den.aspects.utils.ydotool = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.ydotool
      ];
    };
  };
}
