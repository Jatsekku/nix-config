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
  cfg = config.myNixOS.tree;
in
{
  options.myNixOS.tree = {
    enable = lib.mkEnableOption "Unix tree command";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tree
    ];
  };
}
