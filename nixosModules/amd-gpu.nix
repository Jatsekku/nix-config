{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.myNixOS.amdgpu;
in
{
  options.myNixOS.amdgpu = {
    hip = lib.mkEnableOption "HIP support for AMD GPU";
    opencl = lib.mkEnableOption "OpenCL support for AMD GPU";
  };

  # https://nixos.wiki/wiki/AMD_GPU
  config = {

    # Conditonally enable HIP
    systemd.tmpfiles.rules = lib.optionals cfg.hip [
      "L+ /opt/rocm/hip - - - - ${pkgs.rocmPackages.clr}"
    ];

    # Conditionally enable openCL
    hardware.amdgpu.opencl.enable = cfg.opencl;
    environment.systemPackages = lib.optionals cfg.opencl (
      with pkgs;
      [
        clinfo
        rocmPackages.rocminfo
      ]
    );
  };
}
