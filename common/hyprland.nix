{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      lxqt.lxqt-policykit
    ];
  };

  programs.hyprland = {
    # Enable hyprland
    enable = true;
    xwayland.enable = true;
  };
}
