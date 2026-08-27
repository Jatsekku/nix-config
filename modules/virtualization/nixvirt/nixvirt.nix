{
  den,
  inputs,
  lib,
  ...
}:
let
  writeXML = inputs.nixvirt.lib.domain.writeXML;
in
{
  den.aspects.virtualization.nixvirt = {
    includes = [ den.aspects.virtualization.libvirtd ];

    nixos = {
      imports = [ inputs.nixvirt.nixosModules.default ];
      virtualisation.libvirt.enable = true;
    };

    # Windows 10 subaspect
    # (den.aspects.virtualization.nixvirt.windows10 { ... })
    provides.windows10.__functor =
      _self:
      {
        name ? "test-win",
        disks ? null,
      }:
      {
        # Include base nixvirt aspect
        includes = [ den.aspects.virtualization.nixvirt ];

        nixos =
          { pkgs, ... }:
          let
            windows10Template = import ./_templates/windows10.nix {
              inherit pkgs lib;
            };
          in
          {
            virtualisation.libvirt = {
              connections."qemu:///system" = {
                domains = [
                  {
                    active = false;
                    definition = writeXML (
                      # 2. Apply name to the resulting function
                      windows10Template { inherit name disks; }
                    );
                  }
                ];
              };
            };
          };
      };

    # Linux subaspect
    # (den.aspects.virtualization.nixvirt.linux { ... })
    provides.linux.__functor =
      _self:
      {
        name ? "test-win",
        disks ? null,
      }:
      {
        # Include base nixvirt aspect
        includes = [ den.aspects.virtualization.nixvirt ];

        nixos =
          { pkgs, ... }:
          let
            linuxTemplate = import ./_templates/linux.nix {
              inherit pkgs lib;
            };
          in
          {
            virtualisation.libvirt = {
              connections."qemu:///system" = {
                domains = [
                  {
                    active = false;
                    definition = writeXML (
                      # 2. Apply name to the resulting function
                      linuxTemplate { inherit name disks; }
                    );
                  }
                ];
              };
            };
          };
      };
  };
}
