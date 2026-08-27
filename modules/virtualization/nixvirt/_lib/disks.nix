{ lib }:
let
  mkDisk =
    {
      path,
      serial,
      bus,
      index,
      diskType,
    }:
    let
      genericSerial = "generic-${bus}sn-${toString index}";
      effectiveSerial = if serial != null then serial else genericSerial;

      alphabet = "abcdefghijklmnopqrstuvwxyz";
      diskLetter = if index < 26 then builtins.substring index 1 alphabet else throw "Too many disks!";

      targetDev =
        if bus == "nvme" then
          "nvme${toString index}n1"
        else if bus == "sata" then
          "sd" + diskLetter
        else
          "vd" + diskLetter;
    in
    {
      device = if diskType.isIso then "cdrom" else "disk";
      type = if diskType.isBlock then "block" else "file";

      driver = {
        name = "qemu";
        type = if diskType.isQcow2 then "qcow2" else "raw";
      };

      source = if diskType.isBlock then { dev = path; } else { file = path; };

      target = {
        dev = targetDev;
        bus = bus;
      };
    }
    // (if diskType.isIso then { readonly = true; } else { })
    // (if diskType.isBlock then { serial = effectiveSerial; } else { });

  normalizeItem =
    item:
    if builtins.isString item then
      { path = item; }
    else if builtins.isAttrs item && item ? path then
      item
    else
      throw "Invalid disk input: expected a string path or an attribute set with a 'path' attribute.";

  getDiskType = path: {
    isBlock = builtins.match "^/dev/.*" path != null;
    isNvme = builtins.match ".*nvme.*" path != null;
    isQcow2 = builtins.match ".*\\.qcow2$" path != null;
    isIso = builtins.match ".*\\.iso$" path != null;
  };

  getBusType =
    {
      diskType,
      bus ? null,
      ...
    }:
    if diskType.isIso then
      "sata"
    else if diskType.isNvme then
      "nvme"
    else if diskType.isBlock then
      "sata"
    else if bus != null then
      bus
    else
      "virtio";
in
{
  inherit mkDisk;

  mkDisks =
    disksInfo:
    let
      normalizedList =
        if disksInfo == null then
          [ ]
        else if builtins.isString disksInfo then
          [ { path = disksInfo; } ]
        else if builtins.isAttrs disksInfo then
          [ disksInfo ]
        else if builtins.isList disksInfo then
          map normalizeItem disksInfo
        else
          throw "Unsupported disk input type.";

      taggedList =
        (lib.foldl'
          (
            acc:
            {
              path,
              serial ? null,
              bus ? null,
            }:
            let
              diskType = getDiskType path;
              resolvedBus = getBusType { inherit diskType bus; };
              index = acc.counts.${resolvedBus} or 0;

              diskInfo = {
                path = path;
                serial = serial;
                bus = resolvedBus;
                index = index;
                diskType = diskType;
              };
            in
            {
              items = acc.items ++ [ diskInfo ];
              counts = acc.counts // {
                ${resolvedBus} = index + 1;
              };
            }
          )
          {
            items = [ ];
            counts = { };
          }
          normalizedList
        ).items;
    in
    map mkDisk taggedList;
}
