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
  ];
  programs.git ={
    enable = true;
    userName = "columcrowe";
    userEmail = "colum.crowe@gmail.com";
  };
  programs.fuzzel.enable = true;
  programs.alacritty.enable = true;
  programs.waybar.enable = true;
  programs.bash.enable = true;
  programs.bash.profileExtra = ''
    if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
      export XDG_RUNTIME_DIR="/run/user/$(id -u)"
      export DISPLAY=":0"
      export NIXOS_OZONE_WL="1"
      echo starting
      exec niri-session
    fi
  '';
  programs.chromium.enable = true;
  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}
