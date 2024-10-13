{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  ...
}:
{
  options.myNixOS = {
    docker.enable = lib.mkEnableOption "Enable docker";
  };

  config = lib.mkIf config.myNixOS.docker.enable {
    # Add docker package
    environment.systemPackages = [ pkgs.docker ];
    virtualisation.docker.enable = true;
  };
}
