{ pkgs, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.runAsRoot = true;
    };
  };

  environment.systemPackages = with pkgs; [
    qemu_kvm
    qemu
  ];

  programs.virt-manager.enable = true;
}
