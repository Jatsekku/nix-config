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
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  options.myHomeManager = {
    nixvim.enable = lib.mkEnableOption "Enable nixvim";
  };

  config = lib.mkIf config.myHomeManager.nixvim.enable {
    programs.nixvim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
