{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.kicad;
in
{
  options.myNixOS.kicad = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable KiCad";
    };
  };

  config =
    let
      kicad = pkgs.kicad.override {
        addons = with pkgs.kicadAddons; [
          kikit
          kikit-library
        ];
      };
    in
    lib.mkIf cfg.enable {
      # Add KiCad package
      environment.systemPackages = [ pkgs.kicad ];
    };
}
