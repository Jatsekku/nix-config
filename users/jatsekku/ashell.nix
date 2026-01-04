{ ... }:
{
  programs.ashell.settings = {
    modules = {
      center = [
        "WindowTitle"
      ];
      left = [
        "Workspaces"
      ];
      right = [
        "SystemInfo"
        "Settings"
        "Clock"
        "Tray"
      ];
    };
    workspaces = {
      visibilityMode = "MonitorSpecific";
    };

  };
}
