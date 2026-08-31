{
  den.aspects.editors.arduino = {
    nixos = { pkgs, ... }: {
      # Install Arduino IDE
      environment.systemPackages = [
        pkgs.arduino-ide
      ];
    };

    # Add users to dialout group
    provides.to-users = { user, ... }: {
      nixos.users.users.${user.name}.extraGroups = [ "dialout" ];
    };
  };
}
