let
  diskId = "usb-MS_YSUSP20-256GSR_AA000000000000000479-0:0";
in
{
  disko.devices = {
    disk.usb = {
      type = "disk";
      device = "/dev/disk/by-id/${diskId}";
      content = {
        type = "gpt";
        partitions = {
          # Needed for GRUB compatibility!
          MBR = {
            type = "EF02";
            size = "1M";
            priority = 1;
          };

          # EFI partition
          ESP = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };

          # Public NTFS partition
          public = {
            size = "64G";
            type = "0700";
            content = {
              type = "filesystem";
              format = "ntfs";
              mountpoint = "/mnt/public";
            };
          };

          # Private NTFS partition
          private = {
            size = "64G";
            type = "0700";
            content = {
              type = "filesystem";
              format = "ntfs";
              mountpoint = "/mnt/private";
            };
          };

          # Encrypted NixOS root
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  root = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  home = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  nix = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
