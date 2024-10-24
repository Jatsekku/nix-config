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
    openssh.enable = lib.mkEnableOption "Enable openssh";
  };

  config = lib.mkIf config.myNixOS.openssh.enable {
    services.openssh.enable = true;
  };
}
