{ ... }:
{
  imports = [
    ./bootloader.nix
    ./erase_darlings.nix
    ./i18n.nix
    ./nix.nix
    ./packages.nix
  ];
}
