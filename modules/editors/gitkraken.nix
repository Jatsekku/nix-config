{ den, ... }: {
  den.aspects.editors.gitkraken = {
    # Allow unfree software
    includes = [
      (den.batteries.unfree [
        "gitkraken"
      ])
    ];

    nixos = { pkgs, ... }: {
      # Install GitKraken
      environment.systemPackages = with pkgs; [
        gitkraken
      ];
    };
  };
}
