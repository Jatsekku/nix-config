# Windows 10 Template: Performance & Simplicity
{ pkgs, lib, ... }:
{
  name,
  uuid ? null,
  memory ? {
    count = 4;
    unit = "GiB";
  },
  vcpu ? {
    count = 2;
    placement = "static";
  },
  arch ? "x86_64",
  disks ? null,
  nvram_path ? "/var/lib/libvirt/qemu/nvram/${name}_VARS.fd",
  unattend_xml ? ./autounattend2.xml,
}:
let
  base =
    import ./base.nix
      {
        inherit pkgs lib;
      }
      {
        inherit
          name
          uuid
          memory
          vcpu
          arch
          disks
          ;
      };

  # Handling virtio-win driver
  baseDisks = base.devices.disk;
  hasVirtioDisk = lib.any (d: (d.target.bus or null) == "virtio") baseDisks;
  virtioWinIsoDisk = {
    type = "file";
    device = "cdrom";
    driver = {
      name = "qemu";
      type = "raw";
    };
    source = {
      file = "${pkgs.virtio-win.src}";
    };
    target = {
      bus = "sata";
      dev = "sdz";
    };
    readonly = true;
  };

  # Handling autounattend xml/iso
  unattendIso =
    pkgs.runCommand "autounattend.iso"
      {
        nativeBuildInputs = [
          pkgs.xorriso
        ];
      }
      ''
        mkdir -p staging
        cp ${unattend_xml} staging/autounattend.xml
        xorriso -as mkisofs -iso-level 3 -o $out -V UNATTEND staging
      '';

  unattendDisk = {
    type = "file";
    device = "cdrom";
    driver = {
      name = "qemu";
      type = "raw";
      cache = "none";
    };
    source = {
      file = "${unattendIso}";
    };
    target = {
      bus = "sata";
      dev = "sdb";
    };
    readonly = true;
  };

  effectiveDisks = baseDisks ++ [ unattendDisk ] ++ lib.optionals hasVirtioDisk [ virtioWinIsoDisk ];
in
lib.recursiveUpdate base {
  devices = {
    disk = effectiveDisks;

    graphics = {
      type = "spice";
      autoport = true;
    };

    video = {
      # QXL is recommended for Windows guests
      model.type = "qxl";
    };
  };

  features = {
    # Needed for UEFI support
    acpi = { };
  };

  os = {
    # UEFI
    loader = {
      readonly = true;
      type = "pflash";
      path = "${pkgs.OVMFFull.fd}/FV/OVMF_CODE.ms.fd";
    };
    nvram = {
      template = "${pkgs.OVMFFull.fd}/FV/OVMF_VARS.ms.fd";
      path = nvram_path;
    };
  };

}
