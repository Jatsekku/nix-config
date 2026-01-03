{
  pkgs,
  lib,
  config,
  username,
  ...
}:
let
  cfg = config.myHomeManager.user-ssh-to-age;
in
{
  options.myHomeManager.user-ssh-to-age = {

    enable = lib.mkEnableOption "User-scoped SSH to AGE key autogeneration";

    sshKeyPath = lib.mkOption {
      type = lib.types.str;
      default = "$HOME/.ssh/id_ed25519";
      description = "Path to the source SSH key to convert to AGE";
    };

    ageKeyPath = lib.mkOption {
      type = lib.types.str;
      default = "$HOME/.config/sops/age/keys.txt";
      description = "Path to the result AGE key";
    };

  };

  config = lib.mkIf cfg.enable {
    # One-shot service for generating age key from ssh-key
    systemd.user.services."user-ssh-to-age-${username}" = {
      Unit = {
        Description = "Generate AGE key for user ${username}";
        # Wait for finish of user-ssh-autokeygen service if registered
        After = [ "user-ssh-autokeygen-${username}.service" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = pkgs.writeScript "age-key-generator.sh" ''
          #!${pkgs.bash}/bin/bash
              
          # Path to AGE and SSH keys
          AGE_KEY_PATH="${cfg.ageKeyPath}"
          SSH_KEY_PATH="${cfg.sshKeyPath}"

          # Skip if AGE key already exists
          if [ -f "$AGE_KEY_PATH" ]; then
              echo "AGE key already exists at $AGE_KEY_PATH, skipping generation."
              exit 0
          fi

          # Create directory if necessary
          mkdir -p "$(dirname "$AGE_KEY_PATH")"
          chmod 700 "$(dirname "$AGE_KEY_PATH")"

          # Generate AGE key from SSH key
          ${pkgs.ssh-to-age}/bin/ssh-to-age -private-key -i $SSH_KEY_PATH -o "$AGE_KEY_PATH"
        '';
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
