{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.myNixOS.cryptsetup;
in
{
  options.myNixOS.cryptsetup = {
    enable = lib.mkEnableOption "cryptsetup (LUKS)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      cryptsetup
    ];
  };
}
