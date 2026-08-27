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

  # CPU feature tweaks optimal for a Linux guest
  cpu = {
    features = [
      {
        name = "invtsc";
        policy = "require";
      }
    ];
  };

  # Ensure Linux has a smooth graphical display and input setup out of the box
  devices = base.devices // {
    video = {
      model = {
        type = "virtio";
      };
    };
    graphics = {
      type = "spice";
      autoport = true;
      listen.type = "address";
    };
  };
}
