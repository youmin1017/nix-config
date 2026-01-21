{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/68246da6-5f19-47b2-9451-5ddb202b69ec";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/DA8D-2F50";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };
}
