{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.wireshark;
in
{
  options.myNixOS.wireshark = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable wireshark";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add wireshark package
    environment.systemPackages = [ pkgs.wireshark ];

    # Enable wireshark NixOS module
    programs.wireshark.enable = true;
  };
}
