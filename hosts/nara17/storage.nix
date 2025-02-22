{ config, lib, pkgs, ... }:
{
  fileSystems."/data/appdata" =
    { device = "/dev/sda1";
      fsType = "btrfs";
      options = [ "subvol=appdata" ];
    };

  # fileSystems."/data/media" =
  #   { device = "/dev/sda1";
  #     fsType = "btrfs";
  #     options = [ "subvol=media" "users" ];
  #   };

  # fileSystems."/mnt/share" =
  #   { device = "/dev/sda1";
  #     fsType = "btrfs";
  #     options = [ "subvol=share" "users" ];
  #   };

  # fileSystems."/mnt/datapool" =
  #   { device = "/dev/sda1";
  #     fsType = "btrfs";
  #     options = [ "no-auto" "users" ];
  #   };

  # fileSystems."/mnt/share/public/Downloads" =
  #   { device = "/data/media/torrent/share";
  #     fsType = "none";
  #     options = [ "bind" "users" ];
  #   };
}
