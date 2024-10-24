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
  options.myHomeManager = {
    wofi.enable = lib.mkEnableOption "Enable wofi";
  };

  config = lib.mkIf config.myHomeManager.wofi.enable {
    programs.wofi.enable = true;
  };
}
