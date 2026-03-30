{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.virt-manager;
in
{
  options.myNixOS.virt-manager = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable virt-manager";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable dconf (System Management Tool)
    programs.dconf.enable = true;

    # Install necessary packages
    environment.systemPackages = with pkgs; [
      virt-manager
    ];

    # Manage virtualisation services
    virtualisation = {
      libvirtd = {
        enable = true;
        onShutdown = "shutdown";
        onBoot = "ignore";
        qemu = {
          runAsRoot = true;
          swtpm.enable = true;
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
  };
}
