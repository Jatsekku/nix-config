{ inputs, ... }: {
  den.aspects.system.disko = diskoConfig: {
    nixos.imports = [
      inputs.disko.nixosModules.disko
      diskoConfig
    ];
  };
}
