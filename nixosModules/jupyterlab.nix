{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.myNixOS = {
    jupyterlab.enable = lib.mkEnableOption "JupyterLab";
  };

  config = lib.mkIf config.myNixOS.jupyterlab.enable {
    # Add jupyterlab package
    environment.systemPackages = [ pkgs.python313Packages.jupyterlab ];
  };
}
