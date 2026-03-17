{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/632add57-70d8-44c6-95af-583014d83af6";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/52F2-2CA2";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
}
