{
  myNixOS.hyprland = {
    enable = true;
    hostSettings = {
       source = [ "~/.config/hypr/monitors.conf" ];
    };
  };
}
