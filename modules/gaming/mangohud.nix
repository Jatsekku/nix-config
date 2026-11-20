{
  den.aspects.gaming.mangohud = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        mangohud
      ];
    };
  };
}
