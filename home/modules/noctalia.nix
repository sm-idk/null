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
        settingsVersion = 15;
        bar = {
          widgets = {
            left = [ { id = "Workspace"; } ];
            center = [ { id = "Clock"; } ];
            right = [
              { id = "MediaMini"; }
              { id = "Tray"; }
              { id = "NotificationHistory"; }
              { id = "Volume"; }
              { id = "Brightness"; }
              { id = "Battery"; }
              { id = "SystemMonitor"; }
              { id = "ControlCenter"; }
            ];
          };
        };
        location = {
          name = "Warsaw";
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
