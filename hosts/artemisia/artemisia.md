## Disko-install

In order to burn NixOS system on pendrive run:

```console
sudo nix run github:nix-community/disko#disko-install \
 -- \
 --dry-run \
 --flake /home/jatsekku/nix-config/.#artemisia \
 --disk usb /dev/disk/by-id/usb-MS_YSUSP20-256GSR_AA000000000000000479-0:0
```
