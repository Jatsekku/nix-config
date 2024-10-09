{
  pkgs,
  lib,
  config,
  ...
}:
let
  kicad = pkgs.kicad.override {
    addons = with pkgs.kicadAddons; [
      kikit
      kikit-library
    ];
  };
in
{
  home.packages = with pkgs; [
    kicad
  ];
}
