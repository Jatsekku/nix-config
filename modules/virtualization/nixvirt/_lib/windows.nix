{ pkgs, lib }:
{
  mkUnattendIsoFile =
    unattendXml:
    pkgs.runCommand "autounattend.iso"
      {
        nativeBuildInputs = [ pkgs.xorriso ];
      }
      ''
        mkdir -p staging
        cp ${unattendXml} staging/autounattend.xml
        xorriso -as mkisofs -iso-level 3 -o $out -V UNATTEND staging
      '';
}
