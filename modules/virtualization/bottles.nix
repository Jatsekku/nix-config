{
  den.aspects.virtualization.bottles = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        (bottles.override { removeWarningPopup = true; })
      ];
    };
  };
}
