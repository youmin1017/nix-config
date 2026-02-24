{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5bdddd48-a29c-40ff-aa98-5520e102bff7";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/DA8D-2F50";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
}
