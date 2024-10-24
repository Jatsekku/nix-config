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
    wofi.enable = lib.mkEnableOption "Enable wofi";
  };

  config = lib.mkIf config.myNixOS.wofi.enable {
    # Add wofi package
    environment.systemPackages = [ pkgs.wofi ];
  };
}
