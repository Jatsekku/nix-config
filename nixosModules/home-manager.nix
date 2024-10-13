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
    home-manager.enable = lib.mkEnableOption "Enable home-manager";
  };

  config = lib.mkIf config.myNixOS.home-manager.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
