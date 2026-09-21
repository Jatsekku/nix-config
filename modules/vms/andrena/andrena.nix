{ den, lib, ... }:
let
  name = "Andrena-win10";
  isoFilePath = "/home/jatsekku/Downloads/Win10_22H2_EnglishInternational_x64v1.iso";
  storageDiskPath = "/var/lib/libvirt/images/win10-disk.qcow2";

  extraConfig = {
    devices = {
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
    };
  };
in
{
  den.aspects.vms.andrena = {
    includes = with den.aspects; [
      (virtualization.nixvirt.windows10 {
        inherit name extraConfig;
        disks = [
          { path = isoFilePath; }
          { path = storageDiskPath; }
        ];
      })
    ];
  };
}
