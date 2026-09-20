{
  den.aspects.virtualization.quickemu = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        quickemu
      ];
    };
  };
}
