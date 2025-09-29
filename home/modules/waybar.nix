{ pkgs, ... }:
{

  home.packages = builtins.attrValues {
    inherit (pkgs)
      font-awesome
      ;
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [
      {
        position = "top";
        height = 5;
        modules-left = [
          "niri/workspaces"
          "custom/media"
          "niri/window"
        ];
        modules-center = [
          "clock"
          "mpd"
        ];
        modules-right = [
          "pulseaudio"
          "network"
          "backlight"
          "cpu"
          "memory"
          "battery"
          "battery#bat2"
          "temperature"
          "tray"
        ];
        mpd = {
          format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ ";
          format-disconnected = "Disconnected ";
          format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
          unknown-tag = "N/A";
          interval = 2;
          consume-icons = {
            on = " ";
          };
          random-icons = {
            off = "<span color=\"#f53c3c\"></span> ";
            on = " ";
          };
          repeat-icons = {
            on = " ";
          };
          single-icons = {
            on = "1 ";
          };
          state-icons = {
            paused = "";
            playing = "";
          };
          tooltip-format = "MPD (connected)";
          tooltip-format-disconnected = "MPD (disconnected)";
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
        };
        tray = {
          spacing = 10;
        };
        clock = {
          format = "{:%I:%M }";
          format-alt = "{:%Y-%m-%d}";
        };
        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };
        memory = {
          format = "{}% ";
        };
        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [
            ""
            ""
            ""
          ];
        };
        backlight = {
          format = "{percent}% ";
          format-icons = [
            ""
            ""
          ];
        };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% ";
          format-charging = "{capacity}%";
          format-plugged = "{capacity}%";
          format-alt = "{time} ";
        };
        "battery#bat2" = {
          bat = "BAT2";
        };
        network = {
          format-wifi = "{essid} ";
          # format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
          format-ethernet = "";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        pulseaudio = {
          format = "{volume}%  {format_source}";
          format-bluetooth = "{volume}%  {format_source}";
          format-bluetooth-muted = " {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          on-click = "pavucontrol";
        };
        "custom/media" = {
          format = " {}";
          return-type = "json";
          max-length = 40;
          escape = true;
          exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
        };
      }
    ];

    style = ''
      * {
        border: none;
        border-radius: 4px;
        /* `ttf-font-awesome` is required to be installed for icons */
        font-family: "Roboto Mono Medium", Helvetica, Arial, sans-serif;

        /* adjust font-size value to your liking: */
        font-size: 16px;

        min-height: 0;
      }

      window#waybar {
        background-color: rgba(0, 0, 0, 0.9);
        color: #ffffff;
      }

      #workspaces button {
        color: #ffffff;
        box-shadow: inset 0 -3px transparent;
      }

      #workspaces button:hover {
        background: rgba(0, 0, 0, 0.9);
        box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.focused {
        background-color: #64727d;
      }

      #workspaces button.urgent {
        background-color: #eb4d4b;
      }


      #clock,
      #battery,
      #cpu,
      #memory,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #custom-media,
      #tray,
      #idle_inhibitor,
      #mpd {
        padding: 0 10px;
        margin: 6px 3px;
        color: #000000;
      }

      #window,
      #workspaces {
        margin: 0 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
      }

      #clock {
        background-color: #000000;
        color: white;
      }

      #battery {
        background-color: #000000;
        color: white;
      }

      #battery.charging {
        color: #ffffff;
        background-color: #000000;
      }

      @keyframes blink {
        to {
          background-color: #ffffff;
          color: #000000;
        }
      }

      #battery.critical:not(.charging) {
        background-color: #f53c3c;
        color: #ffffff;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      label:focus {
        background-color: #000000;
      }

      #cpu {
        background-color: #000000;
        color: #ffffff;
      }

      #memory {
        background-color: #000000;
        color: white;
      }

      #backlight {
        background-color: #000000;
        color: white;
      }

      #network {
        background-color: #000000;
        color: white;
      }

      #network.disconnected {
        background-color: #f53c3c;
      }

      #pulseaudio {
        background-color: #000000;
        color: #ffffff;
      }

      #pulseaudio.muted {
        background-color: #000000;
        color: #ffffff;
      }

      #custom-media {
        background-color: #66cc99;
        color: #2a5c45;
        min-width: 100px;
      }

      #custom-media.custom-spotify {
        background-color: #66cc99;
      }

      #custom-media.custom-vlc {
        background-color: #ffa000;
      }

      #temperature {
        background-color: #f0932b;
      }

      #temperature.critical {
        background-color: #eb4d4b;
      }

      #tray {
        background-color: #2980b9;
      }

      #idle_inhibitor {
        background-color: #2d3436;
      }

      #idle_inhibitor.activated {
        background-color: #ecf0f1;
        color: #2d3436;
      }

      #mpd {
        background-color: #66cc99;
        color: #2a5c45;
      }

      #mpd.disconnected {
        background-color: #f53c3c;
      }

      #mpd.stopped {
        background-color: #90b1b1;
      }

      #mpd.paused {
        background-color: #51a37a;
      }

      #language {
        background: #bbccdd;
        color: #333333;
        padding: 0 5px;
        margin: 6px 3px;
        min-width: 16px;
      }
    '';
  };
}
