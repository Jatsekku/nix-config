{ den, ... }:
{
  den.aspects.jatsekku = {
    includes = [
      # TODO: Now I don't know how but specific user aspects
      # living under it's directory should be included automatically.
      # It's rather obvious that on this level config
      # is very specific per user and is not intended to be shared.
      # Yet I still want to apply separation of concerns and keep settings in different files.
      den.aspects.jatsekku.git

      # Define a user at OS and homeManager levels.
      den.batteries.define-user
      # Set as primary user.
      den.batteries.primary-user
      # Set and enable user default shell.
      (den.batteries.user-shell "zsh")
    ];
  };
}
