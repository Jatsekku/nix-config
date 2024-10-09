{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.nh ];

  environment.sessionVariables = {
    FLAKE = "/home/$USER/nix-config";
  };
}
