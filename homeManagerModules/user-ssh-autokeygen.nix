{
  pkgs,
  lib,
  config,
  username,
  ...
}:
{
  options.myHomeManager.user-ssh-autokeygen = {
    enable = lib.mkEnableOption "User-scoped SSH key autogeneration";
  };

  config = lib.mkIf config.myHomeManager.user-ssh-autokeygen.enable {
    # One-shot service for generating ssh key
    systemd.user.services."user-ssh-autokeygen-${username}" = {
      Unit = {
        Description = "Generate SSH key for user ${username}";
      };
      Service = {
        Type = "oneshot";
        ExecStart = ''
          /bin/sh -c '[ ! -f "$HOME/.ssh/id_ed25519" ] && ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -N "" -f "$HOME/.ssh/id_ed25519"'
        '';
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
