{
  myNixOS.hyprland = {
    enable = true;
    hostSettings = {
      monitor = [
        # 1 Screen:
        # "DP-4" -> Display port #4,
        # "1920x1080@60 -> Resolution: 1920 x 1080, Refreshing 60Hz
        # "0x0" -> Postion (x,y) : 0,0
        # "1" -> No scaling
        "HDMI-A-1,1920x1080@60,0x0,1"

        # 2 Screen:
        # "DP-4" -> Display port #4,
        # "1920x1080@60 -> Resolution: 1920 x 1080, Refreshing 60Hz
        # "0x0" -> Postion (x,y) : 0,0
        # "1" -> No scaling
        # "transform,2" -> Rotation 180 degrees
        "HDMI-A-2,1920x1080@60,1920x0,1"
      ];

      # card1 -> [AMD/ATI] Ellesmere [Radeon RX 470/480/570/570X/580/580X/590]
      # card2 -> [AMD/ATI] Navi 23 [Radeon RX 6600/6600 XT/6600M] (rev c1)
      # env = [ "AQ_DRM_DEVICES,/dev/dri/card1" ];
    };
  };
}
