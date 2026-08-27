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
  cpu = {
    features = [
      {
        # Hide KVM from Windows
        name = "kvm";
        policy = "disable";
      }
      {
        name = "invtsc";
        policy = "require";
      }
    ];
  };
}
