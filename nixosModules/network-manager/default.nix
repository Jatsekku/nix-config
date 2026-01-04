{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixOS.network-manager;

  # List of all supported backends
  backends = [
    "networkmanager"
  ];

  # List of enabled backends
  enabledBackends = backends |> lib.filter (name: cfg.${name}.enable);

  # First enabled backend
  selectedBackend = lib.head enabledBackends;
in
{
  imports = [
    ./network-manager.nix
  ];

  options.myNixOS.network-manager = {
    guiCmd = lib.mkOption {
      type = lib.types.str;
      default = cfg.${selectedBackend}.guiCmd;
      description = "Command to run GUI for selected network manager backend";
    };

    #config = {
    #myNixOS.network-manager.guiCmd = cfg.${selectedBackend}.guiCmd;
    #myNixOS.network-manager.guiCmd = "dupa"
    #};
  };
}
