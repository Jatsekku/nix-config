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
        # Host-level secrets
        hostname = config.networking.hostName;
        secretsFile = "${inputs.self}/modules/hosts/${hostname}/secrets.yaml";
        hasSecretsFile = builtins.pathExists secretsFile;
        hostSshPrvKeyFile = "/etc/ssh/ssh_host_ed25519_key";
      in
      {
        imports = [ inputs.sops-nix.nixosModules.sops ];

        environment.systemPackages = with pkgs; [
          age
          sops
          ssh-to-age
        ];

        sops = {
          age.sshKeyPaths = [ hostSshPrvKeyFile ];
          defaultSopsFile = lib.mkIf hasSecretsFile secretsFile;
        };
      };

    homeManager =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      let
        # User-level secrets
        username = config.home.username;
        secretsFile = "${inputs.self}/modules/users/${username}/secrets.yaml";
        hasSecretsFile = builtins.pathExists secretsFile;

        homeDirectory = config.home.homeDirectory;
        userSshPrvKeyFile = "${homeDirectory}/.ssh/id_ed25519";
        userAgeKeysFile = "${homeDirectory}/.config/sops/age/keys.txt";
      in
      {
        imports = [ inputs.sops-nix.homeManagerModules.sops ];

        sops = {
          age.keyFile = userAgeKeysFile;
          defaultSopsFile = lib.mkIf hasSecretsFile secretsFile;
        };

        # User-level AGE key generation
        # Run ssh key generation on HM generation activation
        home.activation.ageAutoKeygen = lib.hm.dag.entryAfter [ "sshAutoKeygen" ] ''
          SSH_KEY_FILE="${userSshPrvKeyFile}"
          AGE_KEY_FILE="${userAgeKeysFile}"
          AGE_KEY_DIR="$(dirname "$AGE_KEY_FILE")"

          if [ ! -f "$AGE_KEY_FILE" ] && [ -f "$SSH_KEY_FILE" ]; then
            echo "Generating default AGE key from SSH key for ${username}..."

            # Ensure the directory exists
            $DRY_RUN_CMD ${pkgs.coreutils}/bin/mkdir -p "$AGE_KEY_DIR"

            # Generate AGE key from SSH key
            $DRY_RUN_CMD ${pkgs.ssh-to-age}/bin/ssh-to-age -private-key -i "$SSH_KEY_FILE" > "$AGE_KEY_FILE"
          fi
        '';
      };
  };
}
