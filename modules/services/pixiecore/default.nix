{
  den,
  inputs,
  lib,
  ...
}:
let
  # Directly target selaginella's configuration from the flake
  targetSys =
    inputs.self.nixosConfigurations.selaginella
      or (throw "Host 'selaginella' not found in nixosConfigurations!");

  build = targetSys.config.system.build;
in
{
  den.aspects.services.pixiecore = {
    nixos = {
      services.pixiecore = {
        enable = true;
        openFirewall = true;
        dhcpNoBind = true;

        mode = "boot";
        kernel = "${build.kernel}/bzImage";
        initrd = "${build.netbootRamdisk}/initrd";
        cmdLine = "init=${build.toplevel}/init loglevel=4";
        debug = true;
      };
    };
  };
}
