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
in
lib.recursiveUpdate base {
  clock = {
    offset = "utc";
    timer = [
      {
        name = "kvmclock";
        present = true;
      }
    ];
  };

  cpu = {
    features = [
      {
        name = "invtsc";
        policy = "require";
      }
    ];
  };

  devices = {
    graphics = {
      type = "spice";
      autoport = true;
    };
    video = {
      model = {
        type = "virtio";
      };
    };
  };
}
