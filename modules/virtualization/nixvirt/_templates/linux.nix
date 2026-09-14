{ pkgs, lib, ... }:
args@{
  name,
  memory ? 2,
  vcpu ? 2,
  ...
}:
let
  base = import ./base.nix { inherit pkgs lib; } args;
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
