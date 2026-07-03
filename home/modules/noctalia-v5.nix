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
      "ipc"
      "call"
    ]
    ++ (pkgs.lib.splitString " " cmd);
in
{
  imports = [ inputs.noctalia.homeModules.default ];

  home.packages = with pkgs; [
    # Plugin/runtime helpers:
    wlr-randr
    iproute2
    sshfs
    fuse3
    unstable.tailscale
  ];

  programs.noctalia = {
    enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      bar = {
        default = {
          capsule = true;
          capsule_padding = 20.0;
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
          font_family = "Unifont";
          margin_edge = 0;
          margin_ends = 0;
          radius_top_left = 0;
          radius_top_right = 0;
          start = [
            "wallpaper"
            "workspaces"
          ];
        };
      };

      control_center = {
        sidebar = "full";
        sidebar_section = "full";
      };

      desktop_widgets = {
        enabled = false;
      };

      idle = {
        behavior_order = [
          "lock"
          "screen-off"
          "lock-and-suspend"
        ];
        behavior = {
          lock = {
            action = "lock";
            enabled = true;
            timeout = 60.0;
          };
          "lock-and-suspend" = {
            action = "lock_and_suspend";
            enabled = false;
            timeout = 900.0;
          };
          "screen-off" = {
            action = "screen_off";
            enabled = false;
            timeout = 660.0;
          };
        };
      };

      location = {
        auto_locate = true;
      };

      lockscreen = {
        blurred_desktop = true;
      };

      lockscreen_widgets = {
        enabled = false;
        schema_version = 2;
        widget_order = [
          "lockscreen-login-box@HDMI-A-1"
          "lockscreen-login-box@eDP-1"
        ];
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
        widget = {
          "lockscreen-login-box@HDMI-A-1" = {
            box_height = 70.0;
            box_width = 400.0;
            cx = 960.0;
            cy = 961.0;
            output = "HDMI-A-1";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_password_hint = true;
            };
          };
          "lockscreen-login-box@eDP-1" = {
            box_height = 70.0;
            box_width = 400.0;
            cx = 960.0;
            cy = 961.0;
            output = "eDP-1";
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              input_opacity = 1.0;
              input_radius = 6.0;
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_password_hint = true;
            };
          };
        };
      };

      shell = {
        app_icon_colorize = true;
        avatar_path = "/home/bruno/Pictures/Wallpapers/ys6ma3bk2wdg1.png";
        font_family = "Unifont";
        polkit_agent = true;
        settings_show_advanced = true;
        panel = {
          transparency_mode = "soft";
        };
      };

      theme = {
        builtin = "Ayu";
        community_palette = "ADW";
        source = "wallpaper";
        wallpaper_scheme = "m3-monochrome";
      };

      wallpaper = {
        default = {
          path = "/home/bruno/Pictures/Wallpapers/1760035282328330.jpg";
        };
        last = {
          path = "/home/bruno/Pictures/Wallpapers/1760035282328330.jpg";
        };
        monitors = {
          "HDMI-A-1" = {
            path = "/home/bruno/Pictures/Wallpapers/1760035282328330.jpg";
          };
          "eDP-1" = {
            path = "/home/bruno/Pictures/Wallpapers/1760035282328330.jpg";
          };
        };
      };
    };
  };

  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+L".action.spawn = noctalia "lockScreen lock";
    XF86MonBrightnessUp = {
      action.spawn = noctalia "brightness increase";
      allow-when-locked = true;
    };
    XF86MonBrightnessDown = {
      action.spawn = noctalia "brightness decrease";
      allow-when-locked = true;
    };
  };
}