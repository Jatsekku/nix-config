{ pkgs, lib }:
let
  disks = import ./disks.nix { inherit lib; };
  misc = import ./misc.nix { inherit pkgs lib; };
  windows = import ./windows.nix { inherit pkgs lib; };
in
disks // misc // windows
