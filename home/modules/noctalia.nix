{
  inputs,
  pkgs,
  config,
  ...
}:
let
  noctalia =
    cmd:
    [
      "noctalia-shell"
      "ipc"
      "call"
    ]
    ++ (pkgs.lib.splitString " " cmd);
in
{
  imports = [ inputs.noctalia.homeModules.default ];

  home.packages = [ inputs.noctalia.packages.${pkgs.system}.default ];
  programs = {
    noctalia-shell = {
      enable = true;
      settings = {
        widgets = {
          left = [
            { id = "Workspace"; }
          ];
          center = [
            { id = "Clock"; }
          ];
          right = [
            { id = "MediaMini"; }
            { id = "Tray"; }
            { id = "NotificationHistory"; }
            { id = "Battery"; }
            { id = "Volume"; }
            { id = "Brightness"; }
            { id = "SystemMonitor"; }
            { id = "ControlCenter"; }
          ];
        };
        location = {
          name = "Warsaw";
        };
        controlCenter = {
          position = "close_to_bar_button";
          quickSettingsStyle = "compact";
          widgets = {
            quickSettings = [
              { id = "WiFi"; }
              { id = "Bluetooth"; }
              { id = "Notifications"; }
              { id = "ScreenRecorder"; }
              { id = "PowerProfile"; }
              { id = "WallpaperSelector"; }
            ];
          };
        };
        colorSchemes = {
          predefinedScheme = "Monochrome";
        };
      };
    };
    niri.settings.binds = with config.lib.niri.actions; {
      "Mod+L".action.spawn = noctalia "lockScreen toggle";
    };
  };
}
