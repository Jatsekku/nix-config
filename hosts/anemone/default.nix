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

  #virtualisation.libvirtd.scopedHooks.qemu.enable = true;
  #virtualisation.libvirtd.scopedHooks.qemu.perGuest."win10".prepare.begin = config.hardware.pciPassthrough.hooksFor."my-set".passExe;
  #virtualisation.libvirtd.scopedHooks.qemu.perGuest."win10".release.end = config.hardware.pciPassthrough.hooksFor."my-set".unpassExe;

  virtualisation.looking-glass = {
    enable = true;
    displays = {
      vd1 = {
        width = 1920;
        height = 1080;
        permissions = {
          user = "jatsekku";
          group = "qemu-libvirtd";
          mode = "0660";
        };
      };
    };
  };

  hardware.pciPassthrough = {
    enable = true;
    devicesLists."my-set" = {
      devices = [
        {
          address = "0000:0d:00.1";
          id = "1002:ab28";
        }
        {
          address = "0000:0d:00.0";
          id = "1002:73ff";
        }
      ];
      bindOnBoot = true;
    };
  };

  virtualisation.libvirtd.qemu.verbatimConfig = ''
    cgroup_device_acl = [
        "/dev/kvmfr0",
        "/dev/kvm",
        "/dev/null"
    ]
  '';

  myNixOS = {
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
    disko.enable = true;
    docker.enable = true;
    virt-manager.enable = true;
    gnome-disk.enable = true;
    gimp.enable = true;
    grim.enable = true;
    slurp.enable = true;
    sddm.enable = true;
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
      enable = false;
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
