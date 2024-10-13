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
  imports = [
  ];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };
}
