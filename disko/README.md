# Disk partitioning

This section describe declarative disk partitioning used on my machine.
I'm gonna use disko to handle that.

## Current hardware setup
| Device | Value           |
| -------|-----------------|
| RAM    | 64GB            |
| Disks  | 1x 1TB SSD NVMe |

## Setup goal
- ZFS as a base filesystem
- Preparetion for impermanence setup
- Storage for future VMs running under control of KVM/QEMU
- No hiberantion (as in this setup it would require 64GB+ of disk storage)
- No encryption

## Open questions
1. How `"rootFsOptions"` should be set? Why some users configs are so extensive and other very minimalistic about that? \
For now I just go through some settings I've seen and try to describe them. Jump to [ZFS tunning section](#zfs-tuning)

2. What `options.mountpoint = "legacy";` means and why everone is using it? \
-> https://superuser.com/questions/790036/what-is-a-zfs-legacy-mount-point \
TL;DR: It seems like it's used in order to provide option of manual mounting instead of mounting dataset under parent dataset.

## Resources
- https://jro.io/truenas/openzfs/ <- One of the best information source of ZFS I've found.
- https://nixos.wiki/wiki/ZFS <- Manual setup of ZFS filesystem for NixOS. Step by step tutorial
- https://github.com/bhougland18/nixos_config <- Manual setup of ZFS filesystem for NixOS. Step by step tutorial
- https://grahamc.com/blog/nixos-on-zfs/ <- More like high-level overview how to set-up ZFS for NixOS
- https://grahamc.com/blog/erase-your-darlings/ <- Soome information how t prepare ZFS/NixOS for impermanence setup
- https://discourse.nixos.org/t/zfs-properties-that-cant-be-changed-after-pool-creation/15231 <- What can and can't be changed after pool creation
- https://jrs-s.net/2018/08/17/zfs-tuning-cheat-sheet/ <- It's... well, ZFS tuning cheat sheet
- https://www.reddit.com/r/zfs/comments/svnycx/a_simple_real_world_zfs_compression_speed_an/ <- Compression speed comparation
- https://hackmd.io/@mhutter/nixos

## ZFS tuning
- `acltype = "posix"` \
Looking through the configs of other users I also saw setting `acltype = "posixacl"` \
Apparently, it's the same setting: https://github.com/openzfs/zfs/blob/master/module/zcommon/zfs_prop.c#L259 \
It enables POSIX ACL that allows more complex permission rules on files. \
I don't understand the details, but I've read that it won't affect performence negatively \
and if you change that on existing FS it will apply only to new files, so it't better to set it on the beginnig. \
https://www.reddit.com/r/zfs/comments/dltik7/whats_the_purpose_of_the_acltype_property/

- `xattr=sa` \
It enables storing xattrs (whatever it is) in system attributes which decreases the amount of read/write and hence increase performence. \
It's especially recommended to set if using `acltype = "posix"`

- `dnodesize=auto` \
It's highly recoommended if `xattr=sa` has been used.

- `normalization = "formD"` \
No idea - but was adviced to set it so

- `compression = "zstd";` \
I've choosen this particular compression algorithm by going through [this reddit post](https://www.reddit.com/r/zfs/comments/svnycx/a_simple_real_world_zfs_compression_speed_an/)

- `relatime = "on";` \
It's viewed as good compromise between `atime="off"` and `atime="on"`


## How to check logical blocksize of disk?
In general, ZFS should be able to check it on it's own and set appropriate `ashift` parameter. \
If you want to set `ashift` manually you can do so by running: \
`blockdev --getbsz /dev/sdX`

## Some general notes

### FS selection
Before installing NixOS some decision has to be made. One of such is what file system should be used in the setup. \
Initially I wanted to use BTRFS, but during my resarch it came out that it's probably not best choice for VMs host system. \
I'm not an expert of BTRFS/ZFS or any FS in general to be honest, but I kinda know what I would expect from it, so here is my list:
1. I want to learn new technology - just to expand my options for future.
2. I want my "partions" (datasets in ZFS land) to have dynamic size as in past I was fighting against improperly chosen sizes of specific partitons.
3. I want to have snapshots support in case I will mess-up with my data.
4. I want be able to store VMs on it.

### Why I choose ZFS over BTRFS?
If I understood it correctly: \
ZFS allows to create entities called zvols that are basically block device which are better choice for storing VMs than subvolumes in BTRFS. \
I also saw some solution for hosting VMs that used ZFS but very few using BTRFS. 


