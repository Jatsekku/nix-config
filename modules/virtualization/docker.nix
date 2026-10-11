{
  den.aspects.virtualization.docker = {

    # Add users to docker group
    provides.to-users = { user, ... }: {
      nixos.users.users.${user.name}.extraGroups = [ "docker" ];
    };

    nixos = {
      virtualisation.docker = {
        enable = true;
      };
    };
  };
}
