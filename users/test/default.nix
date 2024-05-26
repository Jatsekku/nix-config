{ pkgs, ... }:

{
    users.users.test = {
        isNormalUser  = true;
        extraGroups  = [ "wheel"];
        password = "test";
    };

    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.test = import ./home.nix;
    };
}
