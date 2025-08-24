{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.brother-printer;

  brlaser = pkgs.brlaser.overrideAttrs (
    finalAttrs: previousAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "Owl-Maintain";
        repo = "brlaser";
        rev = "bfaf936bf46f7d3a8a993352fbbb9615b4fc532a";
        sha256 = "d5pS75Z7iUaw8qo4U6tqsZR7IJa/PJzJUApz/27elaM=";
      };
    }
  );
in
{
  options.myNixOS.brother-printer = {
    enable = lib.mkEnableOption "Brother printer support";
  };

  config = lib.mkIf cfg.enable {
    services.printing = {
      # Enable local print service (CUPS)
      enable = true;
      # Install brlaser driver package
      drivers = [ brlaser ];
    };

    # Zereconf network discovery
    services.avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };

    # Enable system-config-printer (GUI managment tool)
    programs.system-config-printer.enable = true;
  };
}
