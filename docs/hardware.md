# hardware

https://github.com/NixOS/nixos-hardware
https://github.com/nix-community/nixos-facter
https://github.com/nix-community/nixos-facter-modules

# Why it's needed/useful?
There are a lot of switches that can enable particular system option/drivers/services etc.
They differ from HW to HW (i.e. you don't want to have drivers for intel GPU if using AMD's)
As managing all options for particular HW is dauting task there was need to create Nixos modules
which help with that.

# What it does?
In general all of those provides set of enabled options that in the end resolve to
specific software/settings that are optimized for specified/detected hardware.
 