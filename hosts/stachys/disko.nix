{
  disko.devices = {
    disk = {
      disk1 = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {

            # Needed for GRUB compatibility!
            MBR = {
              type = "EF02";
              size = "1M";
              priority = 1;
            };

            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            swap = {
              size = "12G";
              type = "8200";
              content = {
                type = "swap";
              };
            };

            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "rpool"; # Create ZFS pool called "rpool"
              };
            };
          };
        };
      };
    };
    zpool = {
      rpool = {
        type = "zpool";
        mode = ""; # Using single drive so no mirroring, RAIDZ or things like that
        rootFsOptions = {
          acltype = "posix";
          xattr = "sa";
          dnodesize = "auto";
          normalization = "formD";
          checksum = "edonr";
          compression = "zstd";
          relatime = "on";
          canmount = "off";
          mountpoint = "none";
        };
        options = {
          autotrim = "on";
        };
        datasets = {

          root = {
            type = "zfs_fs";
            mountpoint = "/";
            options.mountpoint = "/";
            # That one result in creating snapshot named "blank" of root dataset as soon as it has been created
            postCreateHook = "zfs snapshot rpool/root@blank";
          };

          nix = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options.mountpoint = "/nix";
            options.atime = "off";
          };

          persist = {
            type = "zfs_fs";
            mountpoint = "/persist";
            options.mountpoint = "/persist";
          };

          home = {
            type = "zfs_fs";
            mountpoint = "/home";
            options.mountpoint = "/home";
          };
        };
      };
    };
  };
}
