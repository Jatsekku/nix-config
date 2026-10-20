{
  den,
  inputs,
  lib,
  ...
}:
let
  sys = lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      ({ modulesPath, ... }: {
        imports = [ (modulesPath + "/installer/netboot/netboot-minimal.nix") ];

        config = {
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
      })
    ];
  };

  build = sys.config.system.build;
in
{
  den.aspects.services.pixiecore = {
    nixos = {
      services.pixiecore = {
        enable = true;
        openFirewall = true;
        dhcpNoBind = true;

        mode = "boot";
        kernel = "${build.kernel}/bzImage";
        initrd = "${build.netbootRamdisk}/initrd";
        cmdLine = "init=${build.toplevel}/init loglevel=4";
        debug = true;
      };
    };
  };
}
