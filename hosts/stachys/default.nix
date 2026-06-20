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
    ./nvidia-gpu.nix
  ];

  myNixOS.grub.enable = true;
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "nvidia-drm.modeset=1"
      "nvidia-drm.fbdev=1"

      # AMD GPU Power Management
      "amdgpu.aspm=1"
      "amdgpu.bapm=1"
      "amdgpu.dc=1"
      "amdgpu.dpm=1"
      "amdgpu.gpu_recovery=1"
      "amdgpu.runpm=1"
      "amdgpu.dcfeaturemask=0x8"

      "amd_pstate=active"

      "pcie_aspm=force"
    ];
    supportedFilesystems = [ "zfs" ];
    loader.grub = {
      #enable = true;
      #efiSupport = true;
      #efiInstallAsRemovable = true;
      #devices = [ "nodev" ];
    };
  };

  programs.bash-logger = {
    enable = true;
    createEtcSymlink = true;
  };

  programs.nix-ld.enable = true;

  facter.reportPath = ./facter.json;

  myNixOS = {
    amdgpu = {
      hip = false;
      opencl = true;
    };
    brillo.enable = true;
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
    cameractrls.enable = true;
    chromium.enable = true;
    cryptsetup.enable = true;
    disko.enable = true;
    docker.enable = true;
    virt-manager.enable = true;
    gnome-disk.enable = true;
    gnome-power-manager.enable = true;
    gimp.enable = true;
    gpu-screen-recorder.enable = true;
    grim.enable = true;
    slurp.enable = true;
    sddm.enable = true;
    jupyterlab.enable = true;
    kde.enable = true;
    kdenlive.enable = true;
    kicad.enable = true;
    libreoffice.enable = true;
    libvirt.enable = true;
    loupe.enable = true;
    network-manager.networkmanager.enable = true;
    bluetooth-manager.blueman.enable = true;
    nerdfonts.enable = true;
    nwg-displays.enable = true;
    openconnect.enable = true;
    wireshark.enable = true;
    wl-clipboard.enable = true;
    waypipe.enable = true;
    vfio = {
      enable = false;
    };
    vlc.enable = true;
    teams.enable = true;
    tree.enable = true;
    zoom-us.enable = true;
    zsh.enable = true;
    remmina.enable = true;
  };

  networking.hostName = "stachys";
  networking.hostId = "0F0F0F01";
  system.stateVersion = "23.11";

  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.xkb = {
    layout = "pl";
  };

  # Power Monitoring service
  services.upower.enable = true;

  # Power Management daemon
  services.auto-cpufreq = {
    enable = false;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      # Smart power profile switching
      TLP_AUTO_SWITCH = 2;
      # Default power profile when switching is disabled or no power source is detected
      TLP_DEFAULT_MODE = "BAL";

      # AUDIO
      # Enable power save on audio devices
      # after 10s (if driver supports timeout)
      SOUND_POWER_SAVE_ON_AC = 30;
      SOUND_POWER_SAVE_ON_BAT = 10;
      SOUND_POWER_SAVE_ON_SAV = 5;
      # Power off the controller togethe with the sound chip
      SOUND_POWER_SAVE_CONTROLLER = true;

      # BATTERY CARE
      # Stop charging batteries at 80%, starts at 40%
      # Behavior depends on battery's capabilities
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
      START_CHARGE_THRESH_BAT1 = 40;
      STOP_CHARGE_THRESH_BAT1 = 80;
      RESTORE_THRESHOLDS_ON_BAT = true;

      # GRAPHICS

      # AMD
      # Dynamically select the optimal power profile
      RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
      RADEON_DPM_STATE_ON_AC = "performance";
      # Enforce lowest clock to save power
      RADEON_DPM_PERF_LEVEL_ON_BAT = "low";
      RADEON_DPM_STATE_ON_BAT = "battery";

      # Adaptive Backlight Modulation (may affect color balance)
      AMDGPU_ABM_LEVEL_ON_AC = 0;
      AMDGPU_ABM_LEVEL_ON_BAT = 4;
      AMDGPU_ABM_LEVEL_ON_SAV = 4;

      # Intel
      INTEL_GPU_POWER_PROFILE_ON_AC = "base";
      INTEL_GPU_POWER_PROFILE_ON_BAT = "power_saving";
      INTEL_GPU_POWER_PROFILE_ON_SAV = "power_saving";

      # NETWROKING
      # WiFI power saving mode
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "off";

      # PLATFORM
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "balanced";
      PLATFORM_PROFILE_ON_SAV = "low-power";

      # CPU
      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";
      CPU_DRIVER_OPMODE_ON_SAV = "active";

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_SCALING_GOVERNOR_ON_SAV = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_SAV = "power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 80;

      # RADIO DEVICE SWITCHING
      # Restore states of devices beetween shutdowns
      RESTORE_DEVICE_STATE_ON_STARTUP = true;

      # Disable devices if not in use (on battery profile)
      DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = "bluetooth nfc wifi wwan";

      # PCIE AUTOSUSPEND AND ASPM
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";

      PCIE_ASPM_ON_AC = "default";
      PCIE_ASPM_ON_BAT = "powersave";

      # USB Autosuspend
      USB_AUTOSUSPEND = true;

      # TRACE MODE
      TLP_DEBUG = "arg bat disk lock nm path pm ps rf run sysfs udev usb";

    };
  };

  # GPUs symlinking
  hardware.gpuSymlinks.devices = {
    igpu = "0000:06:00.0";
    dgpu = "0000:01:00.0";
  };

  #networking.wireless.enable = false;
  #networking.networkmanager.wifi.backend = "iwd";

  # Firmware update daemon
  services.fwupd.enable = true;

  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}
