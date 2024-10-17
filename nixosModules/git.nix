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
    git.enable = lib.mkEnableOption "Enable git";
  };

  config = lib.mkIf config.myNixOS.git.enable {
    # Add git package
    environment.systemPackages = [ pkgs.git ];
  };
}
