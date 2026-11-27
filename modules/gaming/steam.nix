{ den, ... }: {
  den.aspects.gaming.steam = {
    # Allow unfree software
    includes = [
      den.aspects.gaming.mangohud
      (den.batteries.unfree [
        "steam"
        "steam-unwrapped"
      ])
    ];

    nixos = {
      programs.steam.enable = true;
      programs.gamemode.enable = true;
    };
  };
}
