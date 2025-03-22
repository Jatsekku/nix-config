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
  cfg = config.myNixOS.pixiecore;
in
{
  options.myNixOS.pixiecore = {
    enable = lib.mkEnableOption "pixiecore (iPXE server)";
  };

  config = lib.mkIf cfg.enable {
    services.pixiecore = {
      enable = true;
      openFirewall = true;
      dhcpNoBind = true;
      kernel = "https://boot.netboot.xyz";
      #apiServer = "localhost:8080";
    };
  };
}
