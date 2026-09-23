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
        lookingGlassDisplays ? [ ],
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

            # Looking Glass handling
            hasHostLGlassEnabled = lib.attrByPath [ "virtualisation" "looking-glass" "enable" ] false config;
            areLGlassDisplaysRequested = lookingGlassDisplays != [ ];
            lGlassNixVirtSettingsFor = config.virtualisation.looking-glass.nixVirtSettingsFor;
            lGlassDisplaysSettingsQemu =
              assert !areLGlassDisplaysRequested || hasHostLGlassEnabled || throw "Looking Glass not enabled";
              if areLGlassDisplaysRequested then
                lib.concatMap (
                  displayName: lGlassNixVirtSettingsFor.${displayName}.qemuCommandLineArgs
                ) lookingGlassDisplays
              else
                [ ];

            lGlassDisplaysSharedMemory =
              assert !areLGlassDisplaysRequested || hasHostLGlassEnabled || throw "Looking Glass not enabled";
              if areLGlassDisplaysRequested then
                lib.concatMap (
                  displayName: lGlassNixVirtSettingsFor.${displayName}.sharedMemory
                ) lookingGlassDisplays
              else
                [ ];

            lGlassConfig =
              lib.optionalAttrs (lGlassDisplaysSettingsQemu != [ ]) {
                qemu-commandline = {
                  arg = lGlassDisplaysSettingsQemu;
                };
              }
              // lib.optionalAttrs (lGlassDisplaysSharedMemory != [ ]) {
                devices = {
                  shmem = lGlassDisplaysSharedMemory;
                };
              };

            cleanArgs = removeAttrs args [
              "extraConfig"
              "lookingGlassDisplays"
            ];

            finalDomain =
              lib.recursiveUpdate (
                windows10Template cleanArgs // { biosUuid = args.biosUuid or hostUuid; }
              ) extraConfig
              // lGlassConfig;
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
