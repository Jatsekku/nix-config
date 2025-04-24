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
let
  nixvirt = inputs.nixvirt;
  win = import inputs.self.vmConfigurations.win10-hwa { inherit pkgs inputs; };
in
{
  options.myNixOS = {
    libvirt.enable = lib.mkEnableOption "Enable ";
  };

  config = lib.mkIf config.myNixOS.libvirt.enable {
    virtualisation.libvirt = {
      enable = true;
      verbose = true;
    };

    virtualisation.libvirt.connections."qemu:///session".domains = [
      {
        definition = nixvirt.lib.domain.writeXML win;
      }
    ];
  };
}
