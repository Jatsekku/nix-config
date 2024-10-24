{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  username,
  ...
}:
{
  home = {
    stateVersion = "23.11";
  };

  myUserManager.${username} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "libvirtd"
    ];
    hashedPassword = "$2b$05$jjs7/brKslnAFeLKxdVCOOhGg1XQvg070w/RBIpE7suo1d807jHri";
  };

  myHomeManager = {
    fzf.enable = true;
    obsidian.enable = true;
  };
}
