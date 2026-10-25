{
  lib,
    modulesPath,
    ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
      "xhci_pci"
      "ahci"
      "usbhid"
      "uas"
      "sd_mod"
  ];
  boot.kernelModules = [ "kvm-amd" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ff7068d1-f213-4404-bae2-40f9a2f42141";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1DD0-5393";
    fsType = "vfat";
    options = [
      "fmask=0077"
        "dmask=0077"
    ];
  };

# fileSystems."/mnt/sda1" =
# { device = "/dev/disk/by-uuid/FED3-9229";
#   fsType = "vfat";
#   options = [ "fmask=0022" "dmask=0022" ];
# };

#   fileSystems."/mnt/songs" =
#   { device = "/dev/sda1";
#     fsType = "auto";
#     options = [ "defaults" "user" "rw" "utf8" "noauto" "umask=000" ];
# # options = [ "nosuid" "nodev" "nofail" "x-gvfs-show" ];
#   };

  fileSystems."/mnt/songs" = {
    device = "/dev/disk/by-uuid/4b39ca83-30e6-4fe0-944f-4c9abeef259f";
    fsType = "ext4";
    options = [ "nosuid" "nodev" "nofail" "noatime" "x-gvfs-show" ];
  };

  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-uuid/240768ee-64ac-421a-a733-ce43df1a0b0b";
    fsType = "ext4";
    options = [ "nosuid" "nodev" "nofail" "noatime" "x-gvfs-show" ];
  };


  swapDevices = [
  { device = "/dev/disk/by-uuid/db1f12fb-1843-4c27-b4b1-27c848a3d793"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
