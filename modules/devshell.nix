{ inputs, ... }: {
  perSystem =
    { pkgs, system, ... }:
    let
      displayGreetings = ''
        echo "Bootstraping environment"
      '';

      displayToolsVersions = ''
        printf '%.0s-' {1..80}; printf '\n'

        # Get and display Disko version using the exact flake input package
        DISKO_VER=$(${inputs.disko.packages.${system}.disko}/bin/disko --version 2>&1 | head -n1)
        echo "Disko: $DISKO_VER"

        # Get and display NTFS-3G version
        NTFS3G_VER=$(ntfs-3g --version 2>&1 | head -n1 | grep -oP '\d{4}\.\d+\.\d+')
        echo "NTFS-3G: $NTFS3G_VER"

        # Get and display Just version
        JUST_VER=$(just --version 2>&1 | head -n1 | grep -oP '\d+\.\d+\.\d+')
        echo "Just: $JUST_VER"

        printf '%.0s-' {1..80}; printf '\n'
      '';
    in
    {
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.just
          pkgs.ntfs3g
          inputs.disko.packages.${system}.disko
        ];

        shellHook = ''
          ${displayGreetings}
          ${displayToolsVersions}
        '';
      };
    };
}
