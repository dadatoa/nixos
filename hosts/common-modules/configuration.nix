{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  # boot.initrd.kernelModules = [ "wl" ];
  # boot.kernelModules = [ "88x2bu" ]; # "wl"
  # boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  boot.loader.efi.canTouchEfiVariables = true;
  # Set your time zone.
  time.timeZone = "Asia/Bangkok";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.utf8";
    LC_IDENTIFICATION = "fr_FR.utf8";
    LC_MEASUREMENT = "fr_FR.utf8";
    LC_MONETARY = "fr_FR.utf8";
    LC_NAME = "fr_FR.utf8";
    LC_NUMERIC = "fr_FR.utf8";
    LC_PAPER = "fr_FR.utf8";
    LC_TELEPHONE = "fr_FR.utf8";
    LC_TIME = "fr_FR.utf8";
  };
  

  # Enable experimental features 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # allow unfree packages 
  nixpkgs.config.allowUnfree = true; # defined in flake

  environment.systemPackages = with pkgs; [
  btrfs-progs
  curl 
  exfat 
  git
  neovim
  nmap
  tailscale
  wget
  ];

  # Enable networking config with network manager
  networking.networkmanager.enable = true;

  # start ssh-agent
  programs.ssh.startAgent = true;

  services = {
    # enable autorandr pour autodetect monitors 
    # autorandr.enable = true;
    # Enable ssh
    openssh = {
      enable = true;
      openFirewall = true;
    };


    # Enable Tailscale
    tailscale.enable = true;

    # Avahi for auto discover based on hostname
    avahi = {
      publish = {
        enable = true;
        userServices = true;
      };
      enable = true;
      openFirewall = true;
    };

  };

   

  system.stateVersion = "24.11";
}
