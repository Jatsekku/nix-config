{ den, ... }: {
  den.aspects.gaming.steam = {
    # Allow unfree software
    includes = [
      (den.batteries.unfree [
        "steam"
        "steam-unwrapped"
      ])
    ];

    nixos = {
      programs.steam.enable = true;
    };
  };
}
