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
  cfg = config.myNixOS.zsh;
in
{
  options.myNixOS.zsh = {
    enable = lib.mkEnableOption "Enable zsh";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      # Shell must be enabed system-wide, even if already enabled by HM
      enable = true;
    };
  };
}
