{ den, ... }: {
  # INFO: After rebuild reset may be required!
  den.aspects.utils.simple-scan = {
    includes = [
      (den.batteries.unfree [
        # Needed for Brother scanners
        "brscan4"
        "brscan4-etc-files"
        "brother-udev-rule-type1"
      ])
    ];

    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.simple-scan
      ];

      hardware.sane = {
        enable = true;
        brscan4 = {
          enable = true;
          netDevices = {
            dcp1610 = {
              model = "DCP-1610WE";
              #ip = "192.168.0.18";
              nodename = "BRW945330343230";
            };
          };
        };
      };
    };
  };
}
