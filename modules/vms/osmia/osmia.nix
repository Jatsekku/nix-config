{ den, lib, ... }:
{
  den.aspects.vms.osmia = {
    includes = [ den.aspects.virtualization.nix-vm ];

    nixos = { pkgs, ... }: {
      # Required for virtioFS
      #environment.systemPackages = [ pkgs.virtiofsd ];
      virtualisation.libvirtd.qemu.vhostUserPackages = with pkgs; [ virtiofsd ];

      nix-vm.vms."osmia-win10" = {
        os = "windows";

        hooks = {
          prepare.begin = lib.getExe (
            pkgs.writeShellScript "osmia-win10-gpu-unbind" ''
              if [ -e /sys/bus/pci/devices/0000:0d:00.0/driver ]; then
                echo "0000:0d:00.0" > /sys/bus/pci/devices/0000:0d:00.0/driver/unbind
              fi

              if [ -e /sys/bus/pci/devices/0000:0d:00.1/driver ]; then
                echo "0000:0d:00.1" > /sys/bus/pci/devices/0000:0d:00.1/driver/unbind
              fi

              sleep 1

              echo "13" > /sys/bus/pci/devices/0000:0d:00.0/resource0_resize
              sleep 1

              echo "3" > /sys/bus/pci/devices/0000:0d:00.0/resource2_resize
              sleep 2

              echo "1002 73ff" > /sys/bus/pci/drivers/vfio-pci/new_id
              echo "0000:0d:00.0" > /sys/bus/pci/drivers/vfio-pci/bind

              echo "1002 ab28" > /sys/bus/pci/drivers/vfio-pci/new_id
              echo "0000:0d:00.1" > /sys/bus/pci/drivers/vfio-pci/bind
              sleep 1
            ''
          );

          release.end = lib.getExe (
            pkgs.writeShellScript "osmia-win10-gpu-return" ''
              echo "0000:0d:00.0" > /sys/bus/pci/devices/0000:0d:00.0/driver/unbind
              echo "0000:0d:00.1" > /sys/bus/pci/devices/0000:0d:00.1/driver/unbind
              sleep 1

              echo "0000:0d:00.0" | sudo tee /sys/bus/pci/drivers/amdgpu/bind
              echo "0000:0d:00.1" | sudo tee /sys/bus/pci/drivers/snd_hda_intel/bind
              sleep 1
            ''
          );
        };

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
