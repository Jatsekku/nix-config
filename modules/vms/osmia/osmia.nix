{ den, ... }:
{
  den.aspects.vms.osmia = {
    includes = [ den.aspects.virtualization.nix-vm ];

    nixos = {
      nix-vm.vms."osmia-win10" = {
        os = "windows";
        extraNixVirtConfig = {
          devices = {
            # Not recommended for Looking Glass/RAM pinning
            memballoon.model = "none";

            sound = {
              model = "ich9";
              audio = {
                id = 1;
              };
            };
            audio = {
              id = 1;
              type = "spice";
            };
          };
        };
        hardware = {
          cpu.cores = 16;
          ram.amount = "32G";
          disks = [
            { path = "/dev/disk/by-id/nvme-WD_BLACK_SN850X_1000GB_24122X800837"; }
          ];
          displays = [
            { spice = { }; }
            {
              looking-glass = {
                bpp = 16;
                #kvmfr = false;
                permissions = {
                  user = "jatsekku";
                  group = "qemu-libvirtd";
                  mode = "0660";
                };
              };
            }
          ];
          hostDevices.devices = [
            "0d:00.0"
            "0d:00.1"
          ];
        };
      };
    };
  };
}
