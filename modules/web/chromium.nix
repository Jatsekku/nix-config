{ den, ... }: {
  den.aspects.web.chromium = {
    # Allow unfree chromium and widevine-cdm
    includes = [
      (den.batteries.unfree [
        "chromium"
        "chromium-unwrapped"
        "widevine-cdm"
      ])
    ];

    nixos = { pkgs, ... }: {
      # Install chromium with WideVine to play DRM-protected content
      environment.systemPackages = [
        ((pkgs.chromium.override { enableWideVine = true; }).override {
          commandLineArgs = [
            "--ozone-platform-hint=auto"
            "--enable-features=WaylandWindowDecorations"
          ];
        })
      ];
    };
  };
}
