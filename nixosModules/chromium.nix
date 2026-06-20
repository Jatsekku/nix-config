{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.myNixOS.chromium;
in
{
  options.myNixOS.chromium = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable chromium browser";
    };
    withBitwarden = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Bitwarden support in Chromium";
    };
    withDarkReader = mkOption {
      type = types.bool;
      default = true;
      description = "Enable DarkReader support in Chromium";
    };
    withWideVine = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Widevine support in Chromium";
    };
    withUblock = mkOption {
      type = types.bool;
      default = true;
      description = "Add uBlock Origin extension to Chromium";
    };
  };

  config = mkIf cfg.enable {

    # Install chromium with WideVine to play DRM-protected content
    environment.systemPackages = with pkgs; [
      (chromium.override { enableWideVine = cfg.withWideVine; })
    ];

    # Set Chromium as the default browser
    environment.sessionVariables = {
      BROWSER = "chromium";
    };

    programs.chromium = {
      enable = true;

      extensions =
        [ ]
        # uBlock Origin
        ++ optional cfg.withBitwarden "nngceckbapebfimnlniiiahkandclblb"
        ++ optional cfg.withDarkReader "eimadpbcbfnmbkopoojfekhnkhdbieeh"
        ++ optional cfg.withUblock "ddkjiahejlhfcafbddmgiahcphecmpfh";
    };
  };
}
