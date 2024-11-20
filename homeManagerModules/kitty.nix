{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  username,
  ...
}:
{
  options.myHomeManager = {
    kitty.enable = lib.mkEnableOption "Enable kitty";
  };

  config = lib.mkIf config.myHomeManager.kitty.enable {
    programs.kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
      };
    };
  };
}
