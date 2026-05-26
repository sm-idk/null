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

  home.packages = with pkgs; [
    # Plugin/runtime helpers:
    # - display-settings uses wlr-randr
    # - port-monitor shells out to ss from iproute2
    # - kde-connect can browse phone files via sshfs/FUSE
    # - tailscale plugin shells out to tailscale
    wlr-randr
    iproute2
    sshfs
    fuse3
    unstable.tailscale
  ];
  programs = {
    noctalia-shell = {
      enable = true;
      package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
        calendarSupport = true;
      };
      plugins = {
        sources = [
          {
            enabled = true;
            name = "Official Noctalia Plugins";
            url = "https://github.com/noctalia-dev/noctalia-plugins";
          }
          {
            enabled = true;
            name = "Noctalia KDE Connect";
            url = "https://github.com/WerWolv/noctalia-kde-connect";
          }
        ];
        states = {
          "polkit-agent" = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          "display-settings" = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          "port-monitor" = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          "kde-connect" = {
            enabled = true;
            sourceUrl = "https://github.com/WerWolv/noctalia-kde-connect";
          };
          tailscale = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          "privacy-indicator" = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          screenshot = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
        };
        version = 2;
      };
      pluginSettings = {
        "display-settings" = {
          niriConfigPath = "~/.config/niri/config.kdl";
          iconColor = "none";
        };
        "port-monitor" = {
          refreshInterval = 5;
          hideSystemPorts = false;
          hideWhenEmpty = false;
        };
        tailscale = {
          refreshInterval = 5000;
          compactMode = true;
          showIpAddress = true;
          showPeerCount = true;
          hideDisconnected = false;
          hideMullvadExitNodes = true;
          showSearchBar = false;
          terminalCommand = "";
          sshUsername = "";
          pingCount = 5;
          defaultPeerAction = "copy-ip";
          taildropEnabled = true;
          taildropDownloadDir = "~/Downloads";
          taildropReceiveMode = "operator";
          loginServer = "";
        };
        "privacy-indicator" = {
          hideInactive = false;
          enableToast = true;
          removeMargins = false;
          iconSpacing = 4;
          activeColor = "primary";
          inactiveColor = "none";
          micFilterRegex = "";
          camFilterRegex = "";
        };
        screenshot = {
          mode = "region";
        };
      };
      settings = {
        settingsVersion = 15;
        bar = {
          widgets = {
            left = [
              { id = "Workspace"; }
              { id = "plugin:privacy-indicator"; }
              { id = "plugin:port-monitor"; }
              { id = "plugin:display-settings"; }
              { id = "plugin:tailscale"; }
            ];
            center = [ { id = "Clock"; } ];
            right = [
              { id = "MediaMini"; }
              { id = "Tray"; }
              { id = "plugin:kde-connect"; }
              { id = "plugin:screenshot"; }
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
        wallpaper = {
          randomEnabled = false;
          overviewEnabled = false;
          directory = "/home/bruno/Pictures/Wallpapers";
        };
        colorSchemes = {
          # predefinedScheme = "Rosepine";
          # predefinedScheme = "Ayu";
          predefinedScheme = "Rosey AMOLED";
          generateTemplatesForPredefined = false;
        };
        dock.enabled = false;
        overviewEnabled = true;
      };
    };
    niri.settings.binds = with config.lib.niri.actions; {
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
  };
}
