{ den, ... }:
{
  den.aspects.root = {
    nixos = {
      users.users.root = {
        initialPassword = "pass";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG1tSivpTfNN3m2HkwQ1YMeBfh8LkFmiciIsaKxG+/0o"
        ];
      };
    };
  };
}
