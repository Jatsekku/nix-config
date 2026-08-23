{ den, ... }:
{
  den.aspects.jatsekku = {
    includes = [
      # Define a user at OS and homeManager levels.
      den.batteries.define-user
      # Set as primary user.
      den.batteries.primary-user
      # Set and enable user default shell.
      (den.batteries.user-shell "zsh")
    ];
  };
}
