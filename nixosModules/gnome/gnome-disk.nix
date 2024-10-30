{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.gnome-disk;
in
{
  options.myNixOS.gnome-disk = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable gnome disk utility";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      # Add gnome disk utility package
      pkgs.gnome-disk-utility
    ];
  };
}
