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
    git.enable = lib.mkEnableOption "Enable git";
  };

  config = lib.mkIf config.myHomeManager.git.enable {
    programs.git = {
      enable = true;
      userName = username;
    };
  };
}
