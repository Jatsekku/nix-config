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
    ./hyprland.nix
  ];

  programs.bash-logger = {
    enable = true;
    createEtcSymlink = true;
  };

  facter.reportPath = ./facter.json;

  myNixOS = {
    brother-scanner = {
      enable = true;
      netDevices = {
        home = {
          model = "DCP-1610WE";
          ip = "192.168.0.222";
        };
      };
    };
    calibre.enable = true;
    chromium.enable = true;
    docker.enable = true;
    virt-manager.enable = true;
    gnome-disk.enable = true;
    grim.enable = true;
    slurp.enable = true;
    jupyterlab.enable = true;
    kicad.enable = true;
    libreoffice.enable = true;
    libvirt.enable = true;
    loupe.enable = true;
    nerdfonts.enable = true;
    wireshark.enable = true;
    wl-clipboard.enable = true;
    waypipe.enable = true;
    vfio = {
      enable = true;
      devicesID = [
        "0d:00.0"
        "0d:00.1"
      ];
    };
    vlc.enable = true;
    tree.enable = true;
    zsh.enable = true;
    remmina.enable = true;
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
