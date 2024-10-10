{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  hostName,
  ...
}:
{
  options.myNixOS = {
    nh.enable = lib.mkEnableOption "Enable Nix CLI Helper (nh)";
  };

  config = lib.mkIf config.myNixOS.nh.enable {
    # Add nh package
    environment.systemPackages = [ pkgs.nh ];

    # Provide FLAKE variable for NH
    environment.sessionVariables = {
      FLAKE = "/home/$USER/nix-config";
    };
  };
}
