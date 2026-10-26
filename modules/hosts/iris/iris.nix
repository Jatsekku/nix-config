{
  den,
  ...
}:
{
  den.aspects.iris = {
    includes = with den.aspects; [
      editors.nixvim

      services.avahi
      services.home-assistant
      services.immich

      shells.zsh

      (system.disko ./_disko.nix)
      (system.facter ./_facter.json)
      system.facter-debug
      system.git
      system.grub
      system.locale
      system.networkmanager
      system.nh
      system.nix
      system.ssh.server

      utils.fzf
      utils.pciutils
      utils.smart
      utils.tree
      utils.usbutils

      virtualization.docker

      web.chromium
    ];
  };
}
