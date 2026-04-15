{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e9bacebb-91b7-4bad-b750-037b38139678";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/81B1-DE5A";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };
}
