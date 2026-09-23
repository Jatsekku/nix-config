{
  den,
  ...
}:
let
  name = "osmia-win10";
  lookingGlassDisplays = [ "virtDisp0" ];
  storageDiskPath = "/dev/disk/by-id/nvme-WD_BLACK_SN850X_1000GB_24122X800837";
  memory = 32;
  vcpu = 24;

  extraConfig = {
    pm = {
      suspend-to-mem.enabled = false;
      suspend-to-disk.enabled = false;
    };

    devices = {
      # Not recommended for Looking Glass/RAM pinning
      memballoon.model = "none";

      # Network interface
      interface = {
        type = "network";
        source.network = "default";
        model.type = "e1000e";
      };

      video = {
        model = {
          type = "none";
        };
      };

      hostdev = [
        {
          type = "pci";
          managed = true;
          source.address = {
            domain = 0;
            bus = 13;
            slot = 0;
            function = 0;
          };
        }
        {
          type = "pci";
          managed = true;
          source.address = {
            domain = 0;
            bus = 13;
            slot = 0;
            function = 1;
          };
        }
      ];
    };
  };
in
{
  den.aspects.vms.osmia = {
    includes = with den.aspects; [
      (virtualization.nixvirt.windows10 {
        inherit
          name
          memory
          vcpu
          extraConfig
          lookingGlassDisplays
          ;
        disks = [
          { path = storageDiskPath; }
        ];
      })
    ];
  };
}
