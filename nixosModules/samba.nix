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
  cfg = config.myNixOS.samba;
in
{
  options.myNixOS.samba = {
    enable = lib.mkEnableOption "Samba";
    wsdd = lib.mkEnableOption "Web Service Dynamic discovery";
  };

  config = lib.mkIf cfg.enable {
    # Enable the Samba service
    services.samba = {
      enable = true;
      package = pkgs.samba4Full;
      openFirewall = true;
      settings = {
        global = {
          security = "user";
          workgroup = "WORKGROUP";
          "server string" = "smbnix";
        };

        public = {
          path = "/srv/samba/public";
          public = "yes";
          writable = "yes";
          printable = "no";
          browseable = "yes";
          "read only" = "no";
        };
      };
    };

    services.samba-wsdd = lib.mkIf cfg.wsdd {
      enable = true;
      openFirewall = true;
      discovery = true;
    };
  };
}
