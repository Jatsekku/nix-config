{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.conan;
in
{
  options.myNixOS.conan = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable conan module";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add conan package
    environment.systemPackages = [ pkgs.conan ];
  };
}
