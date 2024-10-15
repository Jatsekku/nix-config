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
    fzf.enable = lib.mkEnableOption "Enable fzf";
  };

  config = lib.mkIf config.myHomeManager.fzf.enable {
    programs.fzf.enable = true;
  };
}
