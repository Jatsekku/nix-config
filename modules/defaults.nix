{
  den,
  lib,
  ...
}:
{
  den.default = {
    nixos.system.stateVersion = "25.11";
    homeManager.home.stateVersion = "25.11";
  };

  den.schema.host.includes = [
    # Name each host according to den.hosts.<os>.<hostname>
    den.batteries.hostname
    # Assign hostId hash based on provided hostnme
    den.aspects.system.hostid
  ];

  den.schema.user = {
    classes = lib.mkDefault [
      # Enable homeManager integration for all users
      "homeManager"
    ];
    includes = [
      # Use HM to config zsh for each user
      den.aspects.shells.zsh
      # Set up ssh client config for each user
      den.aspects.system.ssh.client
    ];
  };
}
