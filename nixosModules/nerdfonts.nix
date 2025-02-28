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
let
  cfg = config.myNixOS.nerdfonts;
in
{
  options.myNixOS.nerdfonts = {
    enable = lib.mkEnableOption "nerdfonts";
  };

  config = lib.mkIf cfg.enable {
    fonts.packages =
      [ ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  };
}
