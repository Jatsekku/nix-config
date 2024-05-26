{ pkgs, ... }:

{
    users.users.test = {
        isNormalUser  = true;
        extraGroups  = [ "wheel"];
        password = "test";
    };
}
