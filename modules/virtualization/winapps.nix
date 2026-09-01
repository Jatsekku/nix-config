{ inputs, ... }:
{
  den.aspects.virtualization.winapps = {
    homeManager = {
      imports = [ inputs.winapps-nix.homeManagerModules.default ];

      programs.winapps = {
        enable = true;
        enableLauncher = true;

        settings = {
          flavor = "libvirt";
          vmName = "andrena-win10";
          rdp = {
            flags = "/cert:tofu /sound /microphone +home-drive";
            user = "Winapps";
            pass = "test";
          };
        };
      };
    };
  };
}
