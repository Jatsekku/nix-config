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
    chromium.enable = lib.mkEnableOption "Enable chromium";
  };

  config = lib.mkIf config.myNixOS.chromium.enable {
    # Add chromium package
    environment.systemPackages = [ pkgs.chromium ];
  };
}
