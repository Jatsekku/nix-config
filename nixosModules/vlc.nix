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
    vlc.enable = lib.mkEnableOption "Enable vlc";
  };

  config = lib.mkIf config.myNixOS.vlc.enable {
    # Add vlc package
    environment.systemPackages = [ pkgs.vlc ];
  };
}
