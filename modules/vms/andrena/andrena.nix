{ den, lib, ... }:
{
  den.aspects.vms.andrena = {
    includes = [ den.aspects.virtualization.nix-vm ];

    nixos = { pkgs, ... }: {
      nix-vm.vms."andrena-ubuntu" = {
        os = "linux";
        hardware = {
          cpu.cores = 8;
          ram.amount = "16G";
          disks = [
            { path = "/tmp/isos/ubuntu-26.04.1-desktop-amd64.iso"; }
            {
              path = "/dev/zvol/rpool/andrena-ubuntu";
              bus = "virtio";
            }
          ];
          displays = [
            { spice = { }; }
          ];
        };
      };
    };
  };
}
