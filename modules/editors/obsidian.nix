{ den, ... }: {
  den.aspects.editors.obsidian = {
    # Allow unfree software
    includes = [
      (den.batteries.unfree [
        "obsidian"
      ])
    ];

    nixos = { pkgs, ... }: {
      # Install Obsidian
      environment.systemPackages = [
        pkgs.obsidian
      ];
    };

    homeManager = {
      programs.obsidian.enable = true;
    };
  };
}
