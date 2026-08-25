{
  den.aspects.system.ssh.server = {
    nixos = {
      services.openssh = {
        enable = true;
        openFirewall = true;
      };
    };
  };
}
