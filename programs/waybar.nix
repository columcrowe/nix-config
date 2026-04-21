{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 26;

        modules-left = [ "niri/workspaces" ];
        #modules-center = [ "clock" ];
        modules-right = [ "network" "bluetooth" "pulseaudio" "backlight" "battery" "clock"];

        clock = {
          format = "{:%H:%M}";
          tooltip-format = "{:%Y-%m-%d}";
        };

        network = {
          format-wifi = "wifi:{essid}";
          format-ethernet = "eth:{ifname}";
          format-disconnected = "wifi:offline";
          tooltip-format = "{ipaddr} - {signalStrength}%";
          on-click = "alacritty -e nmtui";
          on-click-right = "nmcli device wifi rescan";
        };

        bluetooth = {
          format = "bluetooth:{status}";
          tooltip = false;
          on-click = "alacritty -e bluetui";
        };

        pulseaudio = {
          format = "vol:{volume}%";
          format-muted = "vol:muted";
          scroll-step = 1;
        };

        backlight = {
          device = "amdgpu_bl1";
          format = "brightness:{percent}%";
          scroll-step = 1;
        };

        battery = {
          format = "bat:{capacity}%";
        };
      };
    };

    style = ''
      * {
        font-family: monospace;
        font-size: 12px;
      }

      window#waybar {
        background: #1e1e1e;
        color: #dddddd;
      }

      #clock,
      #network,
      #bluetooth,
      #pulseaudio,
      #battery,
      #backlight {
        padding: 0 6px;
        margin: 0px;
      }

    '';
  };

}
