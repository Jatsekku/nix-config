{ den, ... }: {
  den.aspects.editors.vscode = {
    # Allow unfree software
    includes = [
      (den.batteries.unfree [
        "code"
        "vscode"
      ])
    ];

    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        vscode-fhs
      ];
    };
  };
}
