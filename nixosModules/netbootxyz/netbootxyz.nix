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
  cfg = config.myNixOS.netbootxyz;
  serverIp = "192.168.0.140";
in
{
  options.myNixOS.netbootxyz = {
    enable = lib.mkEnableOption "netbootxyz";

    volumes = {
      assets = lib.mkOption {
        type = lib.types.str;
        default = "/srv/netbootxyz/assets";
      };

      config = lib.mkOption {
        type = lib.types.str;
        default = "/srv/netbootxyz/config";
      };
    };

    liveEndpoint = lib.mkOption {
      type = lib.types.str;
      default = "https://github.com/netbootxyz";
    };

    winBaseUrl = lib.mkOption {
      type = lib.types.str;
      default = "";
    };

    sambaShare = {
      enable = lib.mkEnableOption "Dedicated Samba share";
      path = lib.mkOption {
        type = lib.types.str;
        default = "/srv/samba/isos";
      };
    };

    dhcpProxy = lib.mkEnableOption "DHCP Proxy";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.oci-containers.backend = "docker";

    # Create local-vars.ipxe file
    environment.etc."netbootxyz/config/menus/local-vars.ipxe".text = ''
      #!ipxe
      set use_proxydhcp_settings ${toString cfg.dhcpProxy}
      set live_endpoint ${cfg.liveEndpoint}
      set win_base_url ${cfg.winBaseUrl}
    '';

    # Running netbootxyz as OCI container
    virtualisation.oci-containers.containers = {
      netbootxyz = {
        image = "ghcr.io/netbootxyz/netbootxyz";
        autoStart = true;

        ports = [
          "3000:3000" # Web UI
          "69:69/udp" # TFTP
          "8080:80" # Nginx
        ];

        environment = {
          PUID = "1000";
          PGID = "1000";
          # Instruct TFTP to operate on single port
          TFTPD_OPTS = "--tftp-single-port";
        };

        volumes = [
          "${cfg.volumes.assets}:/assets"
          "${cfg.volumes.config}:/config"
        ];
      };
    };

    # Allow UDP 69 in firewall (for TFTP)
    networking.firewall.allowedUDPPorts = [
      67
      68
      69
      4011
    ];

    # Allow TCP 3000 in firewall (for Web UI)
    # Allow TCP 8080 in firewall (for Nginx)
    networking.firewall.allowedTCPPorts = [
      3000
      8080
    ];

    # DHCP setup
    services.dnsmasq = lib.mkIf cfg.dhcpProxy {
      enable = true;
      settings = {
        port = 0;
        interface = "eno1";
        bind-dynamic = true;
        log-dhcp = true;
        dhcp-authoritative = true;
        dhcp-range = [ "192.168.0.2,proxy,255.255.255.0" ];
        pxe-service = [
          "x86PC,'netboot (bios)',netboot.xyz.kpxe,${serverIp}"
          "X86-64_EFI,'netboot (efi)',netboot.xyz.efi,${serverIp}"
        ];
      };
    };

    # Provide dedicated samba share
    services.samba = lib.mkIf cfg.sambaShare.enable {
      settings = {
        isos = {
          path = cfg.sambaShare.path;
          public = "yes";
          writable = "yes";
          printable = "no";
          browseable = "yes";
          "read only" = "no";
        };
      };
    };

    # Provide deciated user for samba access
    users.users.netbootxyzClient = {
      isNormalUser = true;
      hashedPassword = "$2b$05$jjs7/brKslnAFeLKxdVCOOhGg1XQvg070w/RBIpE7suo1d807jHri";
    };

    # Create shared directory if it doesn't exist
    systemd.tmpfiles.rules = lib.mkIf cfg.enable [
      "d ${cfg.sambaShare.path} 0755 root root -"
    ];

    # TODO: Samba user has still be set imperatively
  };
}
