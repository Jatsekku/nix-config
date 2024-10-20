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
  options.myUserManager = {
    type = lib.types.attrsOf (lib.types.attrs);
  };

}
