{ lib, config, options, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;
  # boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.device = "nodev"; #UEFI if BIOS point to /dev/sdX
  # boot.loader.grub.useOSProber = true; #handy if you want to go back to dual-booting Windows but for another Linux partition use systemd-boot
  systemd.tpm2.enable = false; #stop timeout
  boot.initrd.systemd.tpm2.enable = false;

  networking.hostName = "laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.firewall.enable = false;

  services.xserver.xkb.layout = "ie"; #before niri

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.light.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    brightnessctl
  ];

  services.gvfs.enable = true; #for nautilus bin
  services.openssh.enable = true;
  services.printing.enable = true;
  virtualisation.docker.enable = true;
  #virtualisation.libvirtd = true;

}
