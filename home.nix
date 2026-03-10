{ lib, config, options, pkgs, inputs, ...}:

{
  home.username = "columcc";
  home.homeDirectory = "/home/columcc";
  home.packages = with pkgs; [
    zip
    unzip
    xz
    ripgrep
    tree
    strace
    usbutils
    nautilus
    devenv
  ];
  programs.git ={
    enable = true;
    userName = "columcrowe";
    userEmail = "colum.crowe@gmail.com";
  };
  programs.neovim.enable = true;
  programs.fuzzel.enable = true;
  programs.alacritty.enable = true;
  #programs.waybar.enable = true;
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 26;

        modules-left = [ "niri/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "network" "pulseaudio" "backlight" "battery" ];

        clock = {
          format = "{:%H:%M}";
        };

        network = {
          format-wifi = "wifi {essid}";
          format-ethernet = "eth";
          format-disconnected = "offline";
          tooltip = false;
          on-click = "alacritty -e nmtui";
        };

        pulseaudio = {
          format = "vol {volume}%";
          scroll-step = 5;
        };

        backlight = {
          device = "amdgpu_bl1";
          format = "☀ {percent}%";
          scroll-step = 1;
        };

        battery = {
          format = "{capacity}%";
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
      #pulseaudio,
      #battery,
      #backlight {
        padding: 0 8px;
      }

      #workspaces button {
        padding: 0 6px;
        color: #dddddd;
      }

      #workspaces button.focused {
        background: #444444;
      }
    '';
  };
  home.pointerCursor = {
    enable = true;
    name = "Vanilla-DMZ";
    size = 24;
    package = pkgs.vanilla-dmz;
  };
  services.wlsunset = {
    enable = true;
    latitude = 53.35;
    longitude = 6.26;
  };
  programs.bash.enable = true;
  programs.bash.profileExtra = ''
    if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
      loginctl show-session $XDG_SESSION_ID -p Type -p Class -p State
      echo "session: $XDG_SESSION_ID"
      loginctl session-status
      echo "runtime: $XDG_RUNTIME_DIR"
      ls -ld $XDG_RUNTIME_DIR
      export XDG_RUNTIME_DIR="/run/user/$(id -u)"
      export DISPLAY=":0"
      export NIXOS_OZONE_WL="1"
      echo starting
      exec niri-session
    fi
  '';
  #programs.bash.profileExtra = ''
  #  if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then 
  #    export NIXOS_OZONE_WL="1"
  #    echo starting
  #    exec qtile start -b wayland
  #  fi
  #'';
  programs.chromium.enable = true;

  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}
