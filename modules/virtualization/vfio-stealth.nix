{ inputs, lib, ... }:
{
  den.aspects.virtualization.vfio-stealth = {
    nixos =
      { config, ... }:
      with lib;
      let
        /*nixfmt:disable*/
        report = config.hardware.facter.report or { };

        hardware = report.hardware or { };
          cpu = hardware.cpu or [ ];
            cpu0 = if cpu != [ ] then head cpu else { };
              rawCpu0Vendor = cpu0.vendor_name or "";

        smbios = report.smbios or { };
          board = smbios.board or { };
            manufacturer = board.manufacturer or "";
            product = board.product or "";
            baseBoardVersion = board.version or "";

          bios = smbios.bios or { };
            biosVendor = bios.vendor or "";
            biosVersion = bios.version or "";
            biosDate = bios.date or "";

          processor = smbios.processor or [ ];
            processor0 = if processor != [ ] then head processor else { };
              socketPrefix = processor0.socket or "";

          cacheList = smbios.cache or [ ];

          memory_device = smbios.memory_device or [ ];
            validMemory = lib.findFirst (d: (d.manufacturer or "Unknown") != "Unknown") { } memory_device;

        cpuVendor =
          if hasInfix "AMD" rawCpu0Vendor then
            "amd"
          else if hasInfix "Intel" rawCpu0Vendor then
            "intel"
          else
            "";

        cache = listToAttrs (
          lib.imap1 (i: c: {
            name = "l" + toString i;
            value = c.size_current;
          }) cacheList
        );

        memory = {
          manufacturer = validMemory.manufacturer or "Unknown";
          partNumber = validMemory.part_number or "Unknown";
          speed = validMemory.speed or 4800;
          #TODO: Add count
        };
        /*nixfmt:enable*/
        # Missing:
        # biosRelease
        # baseBoardSerial serial (same value for both)
      in
      {
        imports = [ inputs.vfio-stealth.nixosModules.default ];

        virtualisation.vfio-stealth = {
          enable = true;
          inherit cpuVendor;
          smbios = {
            inherit
              manufacturer
              product
              biosVendor
              biosVersion
              biosDate
              # biosRelease
              baseBoardVersion
              # baseBoardSerial
              # serial
              socketPrefix
              cache
              # oemStrings
              memory
              ;
          };
        };
      };
  };
}
