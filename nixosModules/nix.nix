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
  config = {
    # Enable Flakes support and new nix CLI tool
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
