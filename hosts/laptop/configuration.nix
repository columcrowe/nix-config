{ lib, config, options, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  ## Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;
  # boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.device = "nodev"; #UEFI if BIOS point to /dev/sdX
  # boot.loader.grub.useOSProber = true; #handy if you want to go back to dual-booting Windows but for another Linux partition use systemd-boot
  systemd.tpm2.enable = false; #stop timeout
  boot.initrd.systemd.tpm2.enable = false;

  ## Networking
  networking.hostName = "laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.wireless.iwd.enable = true; # Faster
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.networkmanager.wifi.backend = "iwd";
  networking.firewall.enable = false;
 
  ## Bluetooth
  hardware.bluetooth.enable = true;

  ## Keyboard
  services.xserver.xkb.layout = "ie"; #before wm

  ## Sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  ## Brightness
  # programs.light.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    brightnessctl
    bluetui
  ];
  #programs.nix-ld.enable = true;
  programs.wireshark.enable = true;

  services.gvfs.enable = true; #for nautilus bin
  services.openssh.enable = true;
  services.printing.enable = true;
  virtualisation.docker.enable = true;
  #virtualisation.libvirtd = true; #enable KVM support for docker, need to enable SVM in BIOS (AMD-V) 
  #services.tailscale = {
  #  enable = true;
  #  authKey = "<tskey->";
  #  autoStart = true;
  #};
  virtualisation.incus.enable = true;
  virtualisation.incus.package = pkgs.incus; #use unstable as default is -lts
  networking.nftables.enable = true;
  # KVM support for incus --vm, need to enable SVM in BIOS
  virtualisation.libvirtd.enable = true;
  boot.kernelModules = [ "kvm" "kvm_amd" ]; # AMD cpu (_intel)

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  #system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
