{ inputs }:
let
  home = import ./home.nix { inherit inputs; };
  system = import ./system.nix { inherit inputs; };
in
home // system
