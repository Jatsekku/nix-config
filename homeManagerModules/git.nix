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
    git.lfs = lib.mkEnableOption "git LFS";
  };

  config = lib.mkIf config.myHomeManager.git.enable {
    programs.git = {
      enable = true;
      userName = username;
      lfs.enable = config.myHomeManager.git.lfs;
    };
  };
}
