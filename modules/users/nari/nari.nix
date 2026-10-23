{ den, ... }:
{
  den.aspects.nari = {
    includes = [
      # Define a user at OS and homeManager levels.
      den.batteries.define-user
      # Set and enable user default shell.
      (den.batteries.user-shell "zsh")
    ];

    nixos = {
      users.users.nari = {
        # Set initial password
        initialHashedPassword = "$y$j9T$vt.vSt2XVyfNC7mdNp8NP0$DBttZwdlvMCvjtkHRiaPXmOMHRcoyXeo9ZAHpDPnht8";
      };
    };
  };
}
