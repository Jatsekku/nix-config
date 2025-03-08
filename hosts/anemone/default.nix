{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  ...
}:
{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
  ];

  facter.reportPath = ./facter.json;

  myNixOS = {
    calibre.enable = true;
    chromium.enable = true;
    docker.enable = true;
    virt-manager.enable = true;
    gnome-disk.enable = true;
    grim.enable = true;
    slurp.enable = true;
    kicad.enable = true;
    libreoffice.enable = true;
    loupe.enable = true;
    nerdfonts.enable = true;
    wireshark.enable = true;
    wl-clipboard.enable = true;
    waypipe.enable = true;
    tree.enable = true;
    zsh.enable = true;
  };

  networking.hostName = "anemone";
  networking.hostId = "0F0F0F01";
  system.stateVersion = "23.11";

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.xkb = {
    layout = "pl";
  };

}
