{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = "disko-placeholder";
      content = {
        type = "gpt";
        partitions = {

          # BIOS
          MBR = {
            type = "EF02";
            size = "1M";
            priority = 1;
          };

          # UEFI
          ESP = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };

          # Public NTFS partition
          storage-public = {
            size = "64G";
            type = "0700";
            content = {
              type = "filesystem";
              format = "ntfs";
              mountpoint = "/mnt/public";
              # Skip zeroing
              extraArgs = [ "-Q" ];
            };
          };

          # Private NTFS partition
          storage-private = {
            size = "64G";
            type = "0700";
            content = {
              type = "filesystem";
              format = "ntfs";
              mountpoint = "/mnt/private";
              # Skip zeroing
              extraArgs = [ "-Q" ];
            };
          };

          # Windows
          windows = {
            size = "80G";
            type = "0700";
            content = {
              type = "filesystem";
              format = "ntfs";
              mountpoint = "/mnt/windows";
              # Skip zeroing
              extraArgs = [ "-Q" ];
            };
          };

          # NixOS
          nixos = {
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
                      "ssd"
                      "space_cache=v2"
                    ];
                  };
                  home = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
                    ];
                  };
                  nix = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                      "ssd"
                      "space_cache=v2"
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
