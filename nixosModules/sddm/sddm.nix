{
  config,
  lib,
  ...
}:
let
  cfg = config.myNixOS.sddm;
in
{
  options.myNixOS.sddm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable SDDM";
    };
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
