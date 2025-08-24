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
let
  cfg = config.myHomeManager.zsh;
in
{
  options.myHomeManager.zsh = {
    enable = lib.mkEnableOption "ZSH";
    useAsDefault = lib.mkEnableOption "ZSH as default shell";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;

      # Let terminal tracks current working dir
      enableVteIntegration = true;

      # Enable oh-my-zsh
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" ];
      };
    };
  };
}
