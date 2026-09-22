{
  den,
  ...
}:
let
  name = "andrena-win10";
  lookingGlassDisplays = [ ];
  isoFilePath = "/home/jatsekku/Downloads/Win10_22H2_EnglishInternational_x64v1.iso";
  storageDiskPath = "/var/lib/libvirt/images/win10-disk.qcow2";
  memory = 8;
  vcpu = 8;

  extraConfig = {
    devices = {
      # QEMU Guest Agent
      channel = [
        {
          type = "unix";
          source = {
            mode = "bind";
          };
          target = {
            type = "virtio";
            name = "org.qemu.guest_agent.0";
          };
        }
      ];

      # Network interface
      interface = {
        type = "network";
        source.network = "default";
        model.type = "virtio";
      };
    };
  };
in
{
  den.aspects.vms.andrena = {
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
          { path = isoFilePath; }
          { path = storageDiskPath; }
        ];
      })
    ];
  };
}
