{
  # RATIONALE: Git is crucial for NixOS
  # so I decided to place it under system
  den.aspects.system.git = {
    nixos = {
      programs.git = {
        enable = true;
      };
    };
  };
}
