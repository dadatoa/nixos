{ config, pckgs, ... }:
{
  imports = [
    ../common-modules/configuration.nix
    ../common-modules/users.nix
    ../../hardware-configuration.nix
  ];

  networking.hostName = "utm-lab-1";
  networking.firewall.enable = false;
  
}
