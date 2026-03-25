{
  ...
}:
{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ./hyprland.nix
  ];

  # TODO: It may be worth to refactor
  myNixOS.grub.enable = false;
  boot = {
    kernelParams = [
      "nomodeset=0"
      "nvidia-drm.modeset=1"
    ];
    supportedFilesystems = [ "btrfs" ];
    loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      devices = [ "nodev" ];
    };
  };

  boot.initrd.kernelModules = [
    "amdgpu"
    "i915"
    "nouveau"
  ];

  myNixOS = {
    chromium.enable = true;
    network-manager.networkmanager.enable = true;
    nwg-displays.enable = true;
    sddm.enable = true;
  };

  networking.hostName = "artemisia";
  networking.hostId = "0F0F0F03";
  system.stateVersion = "25.11";

  # Specific for portable NixOS
  hardware.enableAllFirmware = true;
  #hardware.enableAllHardware = true;
  services.xserver.videoDrivers = [ "modesetting" ];

}
