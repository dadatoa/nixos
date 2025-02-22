{ config, pckgs, ... }:
{
  imports = [
    ../common-modules/configuration.nix
    ../common-modules/users.nix
    ../../hardware-configuration.nix
  ];

  networking.hostName = "macmini";
  networking.firewall.enable = false;
  
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
    samba = {
      package = pkgs.samba4Full;
      enable = true;
      openFirewall = true;
      
      settings = {
        global = {
          # "guest account" = "nobody";
          # "workgroup" = "WORKGROUP";
          # "server string" = "smbnix";
          # "netbios name" = "smbnix";
          # security = user;
        # };

        # "Papa" = {
          # "path" = "/mnt/share/Papa";
          # "writable" = "yes";
          # "browseable" = "yes";
          # # "guest ok" = "yes";
          # # "read only" = "no";
          # # "create mask" = "0644";
          # # "directory mask" = "0755";
        # };

        # "Natcha" = {
          # "path" = "/mnt/share/Natcha";
          # "writable" = "yes";
          # "browseable" = "yes";
          # # "guest ok" = "yes";
          # # "read only" = "no";
          # # "create mask" = "0644";
        # };

        # "Public" = {
          # "path" = "/mnt/share/public";
          # "writable" = "yes";
          # "browsable" = "yes";
          # "guest ok" = "yes";
          # "read only" = "no";
          # "force user" = "nobody";
          # "force group" = "nogroup";
          # # "create mask" = "666";
        # };
      };
    };
  
    # samba-wsdd for autodiscovery on windows
    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };

  };
}
