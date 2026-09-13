{ den, ... }: {
  den.aspects.ai.claude = {
    # Allow unfree software
    includes = [
      (den.batteries.unfree [
        "claude-code"
      ])
    ];

    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.claude-code
      ];
    };
  };
}
