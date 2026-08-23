let
  # Hostname-based hashId generator function
  mkHostId = hostname: builtins.substring 0 8 (builtins.hashString "sha256" hostname);
in
{
  den.aspects.system.hostid = {
    nixos = { config, ... }: {
      # Assign hostId hash based on provided hostnme
      networking.hostId = mkHostId config.networking.hostName;
    };
  };
}
