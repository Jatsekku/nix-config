{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.nh;
in
{
  options.myNixOS.nh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Nix CLI Helper (nh)";
    };
  };

  config = lib.mkIf cfg.enable {
    # Add nh package
    environment.systemPackages = [ pkgs.nh ];

    # Provide FLAKE variable for NH
    environment.sessionVariables = {
      NH_FLAKE = "/home/$USER/nix-config";
    };
  };
}
