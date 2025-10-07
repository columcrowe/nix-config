{
  disko.devices.disk.main = {
    device = "/dev/sdc";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        boot = {
          type = "EF00";
          size = "512M";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "fmask=0077" "dmask=0077" ];
          };
        };
        root = {
          type = "8300";
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };

#  disko.devices.disk.swapdisk = {
#    device = "/dev/sdX";
#    type = "disk";
#    content = {
#      type = "gpt";
#      partitions = {
#        swap = {
#          size = "100%";
#          type = "8200";
#          content = {
#            type = "swap";
#          };
#        };
#      };
#    };
#  };

}

