{ pkgs, ... }:

{
    users.users.jatsekku = {
        isNormalUser  = true;
        extraGroups  = [ "wheel"];
        hashedPassword = "$2b$05$jjs7/brKslnAFeLKxdVCOOhGg1XQvg070w/RBIpE7suo1d807jHri";
    };

    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.jatsekku = import ./home.nix;
    };
}
