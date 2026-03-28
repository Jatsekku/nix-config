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

  myNixOS.grub.enable = false;
  boot = {
    supportedFilesystems = [ "zfs" ];
    loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      devices = [ "nodev" ];
    };
  };

  programs.bash-logger = {
    enable = true;
    createEtcSymlink = true;
  };

  facter.reportPath = ./facter.json;

  myNixOS = {
    amdgpu = {
      hip = false;
      opencl = true;
    };
    brillo.enable = true;
    brother-printer.enable = true;
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
    cryptsetup.enable = true;
    disko.enable = true;
    docker.enable = true;
    virt-manager.enable = true;
    gnome-disk.enable = true;
    gnome-power-manager.enable = true;
    gimp.enable = true;
    grim.enable = true;
    slurp.enable = true;
    sddm.enable = true;
    jupyterlab.enable = true;
    kdenlive.enable = true;
    kicad.enable = true;
    libreoffice.enable = true;
    libvirt.enable = true;
    loupe.enable = true;
    network-manager.networkmanager.enable = true;
    bluetooth-manager.blueman.enable = true;
    nerdfonts.enable = true;
    nwg-displays.enable = true;
    wireshark.enable = true;
    wl-clipboard.enable = true;
    waypipe.enable = true;
    vfio = {
      enable = false;
    };
    vlc.enable = true;
    tree.enable = true;
    zsh.enable = true;
    remmina.enable = true;
  };

  networking.hostName = "stachys";
  networking.hostId = "0F0F0F01";
  system.stateVersion = "23.11";

  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.xkb = {
    layout = "pl";
  };

  # Power Monitoring service
  services.upower.enable = true;

  # Power Management daemon
  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;

  # GPUs symlinking
  hardware.gpuSymlinks.devices = {
    igpu = "0000:06:00.0";
    dgpu = "0000:01:00.0";
  };
}
