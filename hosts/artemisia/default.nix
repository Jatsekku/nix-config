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
    supportedFilesystems = [ "btrfs" ];
    loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      devices = [ "nodev" ];
    };
  };

  networking.hostName = "artemisia";
  networking.hostId = "0F0F0F03";
  system.stateVersion = "25.11";

  # Specific for portable NixOS
  hardware.enableAllFirmware = true;
  hardware.enableAllHardware = true;
}
