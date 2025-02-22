{ config, lib, pkgs,  ... }:
{

  imports = [
    /etc/nixos/hardware-configuration.nix
    ../common-modules/configuration.nix
    ../common-modules/users.nix

    ./systemcron.nix
  ];
  networking = {
    hostName = "nara17";
    ## enable networking config with network manager
    networkmanager.enable = true;
    ## firewall
    firewall = {
      enable = false; # for testing purpose
    };
  };

  fileSystems."/data/appdata" =
    { device = "/dev/sda1";
      fsType = "btrfs";
      options = [ "subvol=appdata" "users" ];
    };

  fileSystems."/data/media" =
    { device = "/dev/sda1";
      fsType = "btrfs";
      options = [ "subvol=media" "users" ];
    };

  fileSystems."/mnt/share" =
    { device = "/dev/sda1";
      fsType = "btrfs";
      options = [ "subvol=share" "users" ];
    };
  fileSystems."/mnt/datapool" =
    { device = "/dev/sda1";
      fsType = "btrfs";
      options = [ "no-auto" "users" ];
    };

  fileSystems."/mnt/share/public/Downloads" =
    { device = "/data/media/torrent/share";
      fsType = "none";
      options = [ "bind" "users" ];
    };

  
  # enable docker and podman
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      # dockerCompat = true; # conflict with docker
      defaultNetwork.settings.dns_enabled = true;
    };
    docker = {
      enable = true;
      liveRestore = false; # docker swarm
        # rootless = {
        # enable = true;
        # setSocketVariable = true;
      # };
    };
  };

  

  services = {

    # samba file sharing
    samba = {
      package = pkgs.samba4Full;
      enable = true;
      openFirewall = true;
      
      settings = {
        global = {
          "guest account" = "nobody";
          # "workgroup" = "WORKGROUP";
          # "server string" = "smbnix";
          # "netbios name" = "smbnix";
          # security = user;
        };

        "Papa" = {
          "path" = "/mnt/share/Papa";
          "writable" = "yes";
          "browseable" = "yes";
          # "guest ok" = "yes";
          # "read only" = "no";
          # "create mask" = "0644";
          # "directory mask" = "0755";
        };

        "Natcha" = {
          "path" = "/mnt/share/Natcha";
          "writable" = "yes";
          "browseable" = "yes";
          # "guest ok" = "yes";
          # "read only" = "no";
          # "create mask" = "0644";
        };

        "Public" = {
          "path" = "/mnt/share/public";
          "writable" = "yes";
          "browsable" = "yes";
          "guest ok" = "yes";
          "read only" = "no";
          "force user" = "nobody";
          "force group" = "nogroup";
          # "create mask" = "666";
        };
      };
    };

    
    # samba-wsdd for autodiscovery on windows
    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };

}
