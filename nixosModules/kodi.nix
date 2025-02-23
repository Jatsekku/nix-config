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
  cfg = config.myNixOS.kodi;
in
{
  options.myNixOS.kodi = {
    enable = lib.mkEnableOption "Kodi Entertainment Center";
    withNetflix = lib.mkEnableOption "Netflix add-on for Kodi";
    withYoutube = lib.mkEnableOption "YouTube add-on for Kodi";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.kodi.withPackages (
        p:
        with p;
        [ ] ++ lib.optionals cfg.withNetflix [ p.netflix ] ++ lib.optionals cfg.withYoutube [ p.youtube ]
      ))
    ];
  };
}
