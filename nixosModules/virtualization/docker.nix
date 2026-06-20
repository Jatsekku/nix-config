{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.docker;
in
{
  options.myNixOS.docker = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "docker";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add docker package
    environment.systemPackages = [ pkgs.docker ];
    virtualisation.docker = {
      enable = true;
      enableNvidia = lib.mkDefault true;
    };

    # Enabling nVidia support in docker requires 32bit drivers
    hardware.graphics.enable32Bit = lib.mkDefault true;

  };
}
