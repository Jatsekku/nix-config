{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  hostName,
  ...
}:
{
  options.myNixOS = {
    libvirt.enable = lib.mkEnableOption "Enable ";
  };

  config = lib.mkIf config.myNixOS.libvirt.enable {
    virtualisation.libvirt = {
      enable = true;
      verbose = true;
    };
  };
}
