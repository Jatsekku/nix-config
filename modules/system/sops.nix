{ inputs, ... }:
{
  den.aspects.system.sops = {
    nixos =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        secretsFile = "${inputs.self}/modules/hosts/${config.networking.hostName}/secrets.yaml";
        hasSecretsFile = builtins.pathExists secretsFile;
      in
      {
        environment.systemPackages = with pkgs; [
          age
          sops
          ssh-to-age
        ];

        imports = [ inputs.sops-nix.nixosModules.sops ];

        sops = lib.mkIf hasSecretsFile {
          defaultSopsFile = secretsFile;
          age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        };
      };

    homeManager =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];

        # User-level AGE key generation
        # Run ssh key generation on HM generation activation
        home.activation.ageAutoKeygen = lib.hm.dag.entryAfter [ "sshAutoKeygen" ] ''
          SSH_KEY_FILE="${config.home.homeDirectory}/.ssh/id_ed25519"
          AGE_KEY_DIR="${config.home.homeDirectory}/.config/sops/age"
          AGE_KEY_FILE="$AGE_KEY_DIR/keys.txt"

          if [ ! -f "$AGE_KEY_FILE" ] && [ -f "$SSH_KEY_FILE" ]; then
            echo "Generating default AGE key from SSH key for ${config.home.username}..."

            # Ensure the directory exists
            $DRY_RUN_CMD ${pkgs.coreutils}/bin/mkdir -p "$AGE_KEY_DIR"

            # Generate AGE key from SSH key
            $DRY_RUN_CMD ${pkgs.ssh-to-age}/bin/ssh-to-age -private-key -i "$SSH_KEY_FILE" > "$AGE_KEY_FILE"
          fi
        '';
      };
  };
}
