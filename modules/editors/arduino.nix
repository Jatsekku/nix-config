{
  den.aspects.editors.arduino = {
    nixos = { pkgs, ... }: {
      # Install Arduino IDE
      environment.systemPackages = [
        pkgs.arduino-ide
      ];
    };
  };
}
