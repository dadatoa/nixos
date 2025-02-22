{ config, lib, pkgs, ... }:
{
  imports = [
    ../common-modules/configuration.nix
    ../common-modules/users.nix
    ./storage.nix
    ./virtualisation.nix
    /etc/nixos/hardware-configuration.nix
  ];

  networking.hostName = "nara17";
  networking.firewall.enable = false;

  services.samba.enable = true;
  services.samba.package = pkgs.samba4Full;
  services.samba.openFirewall = true;
}
