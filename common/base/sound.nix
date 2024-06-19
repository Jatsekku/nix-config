{ pkgs, ... }:

{
  	services.pipewire = {
    	enable = true;
    	audio.enable = true;
    	pulse.enable = true;
    	alsa.enable = true;
    	alsa.support32Bit = true;
    	jack.enable = true;
  	};

	# Fix for failing alsa-store.service
	# https://github.com/NixOS/nixpkgs/issues/319809
	# https://github.com/ryan4yin/nix-config/blob/main/modules/nixos/desktop/peripherals.nix#L27
	sound.enable = false;
}