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
    kitty.enable = lib.mkEnableOption "Enable kitty";
  };

  config = lib.mkIf config.myNixOS.kitty.enable {
    # Add kitty package
    environment.systemPackages = [ pkgs.kitty ];
  };
}
