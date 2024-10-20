{
  pkgs,
  lib,
  config,
  inputs,
  outputs,
  myLib,
  ...
}:
{
  options.myUserManager = lib.mkOption {
    type = lib.types.attrsOf (lib.types.attrs);
    default = { };
  };
}
