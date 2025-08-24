{
  config,
  inputs,
  lib,
  hostname,
  ...
}:
let
  cfg = config.myNixOS.home-manager;
in
{
  options.myNixOS.home-manager = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable home-manager";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      sharedModules = [
        inputs.self.homeManagerModules.default
      ];
      extraSpecialArgs = { inherit inputs hostname; };
    };
  };
}
