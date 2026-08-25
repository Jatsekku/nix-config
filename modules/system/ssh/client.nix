{
  den.aspects.system.ssh.client = {
    homeManager =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {
        # Manage ~/.ssh/config declaratively
        programs.ssh.enable = true;

        # Synchronous activation script: runs on initial boot/switch
        home.activation.sshAutoKeygen = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          KEY_FILE="${config.home.homeDirectory}/.ssh/id_ed25519"

          if [ ! -f "$KEY_FILE" ]; then
            echo "Generating default SSH key for ${config.home.username}..."
            $DRY_RUN_CMD ${pkgs.coreutils}/bin/mkdir -p "${config.home.homeDirectory}/.ssh"
            $DRY_RUN_CMD ${pkgs.coreutils}/bin/chmod 700 "${config.home.homeDirectory}/.ssh"
            $DRY_RUN_CMD ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -N "" -C "${config.home.username}@${config.home.homeDirectory}" -f "$KEY_FILE"
          fi
        '';
      };
  };
}
