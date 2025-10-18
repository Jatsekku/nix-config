{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.myNixOS.disko;
in
{
  options.myNixOS.disko = {
    enable = lib.mkEnableOption "disko (Declarative disk partitioning)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      disko
      # For formating NTFS partitions
      ntfs3g
    ];
  };
}
