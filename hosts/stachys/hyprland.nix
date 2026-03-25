{
  myNixOS.hyprland = {
    enable = true;
    hostSettings = {
      monitor = [
        # Screen 1:
        # "eDP-1" -> Built-in scresen,
        # "2880x1800@120 -> Resolution: 2880 x 1800, Refreshing 120Hz
        # "0x0" -> Postion (x,y) : 0,0
        # "1.125" -> 1.125 scaling
        "eDP-1,2880x1800@120,0x0,1.125"
      ];
      source = [
        # source nwg-displays config
        #"~/.config/hypr/monitors.conf"
      ];
    };
  };
}
