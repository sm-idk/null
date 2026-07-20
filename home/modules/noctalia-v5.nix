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
      "noctalia"
      "msg"
    ]
    ++ (pkgs.lib.splitString " " cmd);
in
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;
    settings = {
      bar.default = {
        capsule = true;
        capsule_padding = 9.0;
        end = [
          "media"
          "tray"
          "notifications"
          "clipboard"
          "volume"
          "brightness"
          "battery"
          "session"
        ];
        margin_edge = 0;
        margin_ends = 0;
        radius_top_left = 0;
        radius_top_right = 0;
        start = [
          "wallpaper"
          "workspaces"
        ];
      };

      control_center = {
        sidebar = "full";
        sidebar_section = "full";
      };

      desktop_widgets.enabled = false;

      idle.behavior.lock = {
        enabled = true;
        timeout = 60.0;
      };

      location.auto_locate = true;
      lockscreen.blurred_desktop = true;

      shell = {
        app_icon_colorize = true;
        font_family = "Unifont";
        polkit_agent = true;
        settings_show_advanced = true;
        panel.transparency_mode = "soft";
      };

      theme = {
        source = "wallpaper";
        wallpaper_scheme = "m3-monochrome";
      };

    };
  };

  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+L".action.spawn = noctalia "session lock";
    XF86MonBrightnessUp = {
      action.spawn = noctalia "brightness-up";
      allow-when-locked = true;
    };
    XF86MonBrightnessDown = {
      action.spawn = noctalia "brightness-down";
      allow-when-locked = true;
    };
  };
}
