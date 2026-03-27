{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixOS.bluetooth-manager;

  # List of all supported backends
  backends = [
    "blueman"
  ];

  # List of enabled backends
  enabledBackends = backends |> lib.filter (name: cfg.${name}.enable);

  # First enabled backend
  selectedBackend = lib.head enabledBackends;
in
{
  imports = [
    ./blueman.nix
  ];

  options.myNixOS.bluetooth-manager = {
    guiCmd = lib.mkOption {
      type = lib.types.str;
      default = cfg.${selectedBackend}.guiCmd;
      description = "Command to run GUI for selected bluetooth manager backend";
    };

    #config = {
    #myNixOS.network-manager.guiCmd = cfg.${selectedBackend}.guiCmd;
    #myNixOS.network-manager.guiCmd = "dupa"
    #};
  };
}
