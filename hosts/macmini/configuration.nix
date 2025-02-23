{ config, pckgs, ... }:
{
  imports = [
    ../common-modules/configuration.nix
    ../common-modules/users.nix
    /etc/nixos/hardware-configuration.nix
  ];
  
  # resodre le prob de nomodetest?
  # boot.initrd.kernelModules = [ fbcon ];
  boot.kernelParams = [ nomodeset ];
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
  
}
