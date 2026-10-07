{ den, ... }:
{
  den.aspects.vms.osmia = {
    includes = [ den.aspects.virtualization.nix-vm ];

    nixos = { pkgs, ... }: {
      # Required for virtioFS
      #environment.systemPackages = [ pkgs.virtiofsd ];
      virtualisation.libvirtd.qemu.vhostUserPackages = with pkgs; [ virtiofsd ];

      nix-vm.vms."osmia-win10" = {
        os = "windows";
        extraNixVirtConfig = {

          # Required for virtioFS
          memoryBacking = {
            source.type = "memfd";
            access.mode = "shared";
          };

          devices = {
            # Not recommended for Looking Glass/RAM pinning
            memballoon.model = "none";

            # Folder shaared over virtioFS
            filesystem = [
              {
                type = "mount";
                accessmode = "passthrough";
                driver.type = "virtiofs";
                source.dir = "/home/jatsekku/osmia-shared";
                target.dir = "osmia";
              }
            ];

            # Audio
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
                width = 5120;
                height = 1440;
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
