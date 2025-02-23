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
  
}
