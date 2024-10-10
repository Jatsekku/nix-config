{
  pkgs,
  lib,
  config,
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
