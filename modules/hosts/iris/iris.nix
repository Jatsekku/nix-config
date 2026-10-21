{
  den,
  ...
}:
{
  den.aspects.iris = {
    includes = with den.aspects; [
      desktop.plasma
      desktop.sddm

      editors.nixvim

      shells.zsh

      (system.disko ./_disko.nix)
      (system.facter ./_facter.json)
      system.facter-debug
      system.flatpak
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
