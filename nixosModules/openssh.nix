{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixOS.openssh;
in
{
  options.myNixOS.openssh = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable openssh";
    };
  };

  config = lib.mkIf cfg.enable {
    # Eable openssh service
    services.openssh.enable = true;
  };
}
