{ lib, ... }:
{
  den.aspects.desktop.sddm = {
    nixos = {
      services.displayManager = {
        # Do not hardcode specific DE/Compositor
        defaultSession = lib.mkForce null;

        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
    };
  };
}
