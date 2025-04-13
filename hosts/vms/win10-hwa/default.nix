{
  pkgs,
  ...
}:
{
  title = "Windows 10";
  name = "win10";
  type = "kvm";
  uuid = "fbe91dfd-fdd9-2e31-1420-50ebf6599a91";

  # RAM
  memory = {
    count = 32;
    unit = "GiB";
  };

  # CPU
  vcpu = {
    count = 24;
    placement = "static";
  };

  cpu = {
    mode = "host-passthrough";
    check = "none";
    migratable = true;
  };

  os = {
    type = "hvm";
    arch = "x86_64";
    machine = "pc-q35-9.2";
    loader = {
      readonly = true;
      type = "pflash";
      path = "${pkgs.OVMFFull.fd}/FV/OVMF_CODE.fd";
    };
    nvram = {
      #   template = "${pkgs.OVMFFull.fd}/FV/OVMF_VARS.fd";
      path = "/var/lib/libvirt/qemu/nvram/win10_VARS.fd";
    };
    boot = [ { dev = "hd"; } ];
  };

  features = {
    acpi = { };
    apic = { };
    hyperv = {
      mode = "custom";
      relaxed.state = true;
      vapic.state = true;
      vpindex.state = true;
      runtime.state = true;
      synic.state = true;
      stimer.state = true;
      frequencies.state = true;
      tlbflush.state = true;
      ipi.state = true;
      avic.state = true;
      spinlocks = {
        state = true;
        retries = 8191;
      };
    };
    vmport.state = false;
  };

  clock = {
    offset = "localtime";
    timer = [
      {
        name = "rtc";
        tickpolicy = "catchup";
      }
      {
        name = "pit";
        tickpolicy = "delay";
      }
      {
        name = "hpet";
        present = false;
      }
      {
        name = "hypervclock";
        present = true;
      }
    ];
  };

  # Power Management
  pm = {
    suspend-to-mem.enabled = false;
    suspend-to-disk.enabled = false;
  };

  # Devices
  devices = {
    emulator = "${pkgs.qemu}/bin/qemu-system-x86_64";

    # Disks
    disk = [
      {
        device = "disk";
        type = "block";
        driver = {
          name = "qemu";
          type = "raw";
          cache = "none";
          io = "native";
          discard = "unmap";
        };
        source.dev = "/dev/nvme0n1";
        target = {
          dev = "sda";
          bus = "sata";
        };
      }
    ];

    # Network interface
    interface = {
      type = "network";
      source.network = "default";
      model.type = "e1000e";
    };

    graphics = {
      type = "spice";
      autoport = true;
      listen.type = "address";
      image.compression = false;
    };

    video = {
      model = {
        type = "qxl";
        vram = 65536;
        heads = 1;
        primary = true;
      };
    };
  };
}
