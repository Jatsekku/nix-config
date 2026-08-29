{ inputs, ... }:
{
  den.aspects.virtualization.passthrough = {
    virtualisation.looking-glass = {
      enable = true;
      displays = {
        vd1 = {
          width = 5120;
          height = 1440;
          permissions = {
            user = "jatsekku";
            group = "qemu-libvirtd";
            mode = "0660";
          };
        };
      };
    };
  };
}
