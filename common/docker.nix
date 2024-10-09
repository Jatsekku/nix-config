{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.docker ];

  # Enable Docker daemon 
  virtualisation.docker.enable = true;
}
