# Windows 10 Template: Performance & Simplicity
{ pkgs, lib, ... }:
args@{
  name,
  memory ? 4,
  vcpu ? 2,
  nvramPath ? "/var/lib/libvirt/qemu/nvram/${name}_VARS.fd",
  unattendXml ? ./autounattend.xml,
  biosUuid ? null,
  disks ? [ ],
  ...
}:
let
  libVirt = import ../../_lib { inherit pkgs lib; };

  normalizedDisks = (if builtins.isList disks then disks else [ disks ]);

  # Inject unattend ISO disk and virtio-win ISO disk
  unattendIsoDisk.path = "${libVirt.mkUnattendIsoFile unattendXml}";
  virtioWinIsoDisk.path = "${pkgs.virtio-win.src}";
  allDisks = normalizedDisks ++ [
    unattendIsoDisk
    virtioWinIsoDisk
  ];

  base = import ../base.nix { inherit pkgs lib; } (
    (removeAttrs args [
      "nvramPath"
      "unattendXml"
      "biosUuid"
      "disks"
    ])
    // {
      disks = allDisks;
    }
  );
in
lib.recursiveUpdate base {
  clock = {
    offset = "localtime";
    timer = [
      {
        name = "rtc";
        present = false;
        tickpolicy = "catchup";
      }
      {
        name = "pit";
        present = false;
        tickpolicy = "delay";
      }
      {
        name = "hpet";
        present = false;
      }
      {
        name = "kvmclock";
        present = false;
      }
      {
        name = "hypervclock";
        present = true;
      }
    ];
  };

  devices = {
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

    hyperv = {
      mode = "custom";
      relaxed = {
        state = true;
      };
      vapic = {
        state = true;
      };
      spinlocks = {
        state = true;
        retries = 8191;
      };
      vpindex = {
        state = true;
      };
      synic = {
        state = true;
      };
      stimer = {
        state = true;
        direct = {
          state = true;
        };
      };
      reset = {
        state = true;
      };
      frequencies = {
        state = true;
      };
      reenlightenment = {
        state = true;
      };
      tlbflush = {
        state = true;
      };
      ipi = {
        state = true;
      };
    };
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
      path = nvramPath;
    };
  };

  sysinfo = {
    type = "smbios";
    bios = [
      {
        name = "uuid";
        value = biosUuid;
      }
    ];
  };
}
