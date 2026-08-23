{
  den.aspects.web.chromium = {
    nixos =
      { pkgs, lib, ... }:
      {
        # Allow unfree chromium and widevine-cdm
        nixpkgs.config.allowUnfreePredicate =
          pkg:
          builtins.elem (lib.getName pkg) [
            "chromium"
            "chromium-unwrapped"
            "widevine-cdm"
          ];

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
