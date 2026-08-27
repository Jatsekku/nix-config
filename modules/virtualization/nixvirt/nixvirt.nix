{
  den,
  inputs,
  lib,
  ...
}:
let
  writeXML = inputs.nixvirt.lib.domain.writeXML;
  windows10TemplatePath = ./_templates/windows/windows10.nix;
  linuxTemplatePath = ./_templates/linux.nix;
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
      args@{
        name,
        extraConfig ? { },
        ...
      }:
      {
        # Include base nixvirt aspect
        includes = [ den.aspects.virtualization.nixvirt ];

        # Add users to kvm and libvirtd groups
        provides.to-users = { user, ... }: {
          nixos.users.users.${user.name}.extraGroups = [
            "kvm"
            "libvirtd"
          ];
        };

        nixos =
          { config, pkgs, ... }:
          let
            windows10Template = import windows10TemplatePath {
              inherit pkgs lib;
            };

            facterReport = config.hardware.facter.report or { };
            hostUuid = lib.attrByPath [ "smbios" "system" "uuid" ] null facterReport;

            cleanArgs = removeAttrs args [ "extraConfig" ];

            finalDomain = lib.recursiveUpdate (
              windows10Template cleanArgs // { biosUuid = args.biosUuid or hostUuid; }
            ) extraConfig;
          in
          {
            virtualisation.libvirt = {
              connections."qemu:///system" = {
                domains = [
                  {
                    active = false;
                    definition = writeXML finalDomain;
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
      args@{
        name,
        extraConfig ? { },
        ...
      }:
      {
        # Include base nixvirt aspect
        includes = [ den.aspects.virtualization.nixvirt ];

        nixos =
          { config, pkgs, ... }:
          let
            linuxTemplate = import linuxTemplatePath {
              inherit pkgs lib;
            };

            cleanArgs = removeAttrs args [ "extraConfig" ];

            finalDomain = lib.recursiveUpdate (linuxTemplate cleanArgs) extraConfig;
          in
          {
            virtualisation.libvirt = {
              connections."qemu:///system" = {
                domains = [
                  {
                    active = false;
                    definition = writeXML finalDomain;
                  }
                ];
              };
            };
          };
      };
  };
}
