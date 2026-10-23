{ den, lib, ... }:
{
  den.aspects.selaginella = {
    nixos = { modulesPath, ... }: {
      imports = [ (modulesPath + "/installer/netboot/netboot-minimal.nix") ];

      services.openssh = {
        enable = true;
        openFirewall = true;

        settings = {
          PasswordAuthentication = false;
          KbdInteractiveAuthentication = false;
        };
      };

      users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG1tSivpTfNN3m2HkwQ1YMeBfh8LkFmiciIsaKxG+/0o"
      ];
    };
  };
}
