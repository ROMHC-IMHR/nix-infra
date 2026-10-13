{
  flake.nixosModules.muncher = {
    services.fstrim.enable = true;
    zramSwap = {
      enable = true;
      priority = 100;
      algorithm = "zstd";
      memoryPercent = 25;
    };
    fileSystems = {
      "/" = {
        label = "mncr-root";
        fsType = "ext4";
      };
      "/boot" = {
        label = "MNCR-BOOT";
        fsType = "vfat";
        options = ["fmask=0077" "dmask=0077"];
      };
      "/home" = {
        label = "mncr-home";
        fsType = "ext4";
      };
      "/nix" = {
        label = "mncr-nix";
        fsType = "ext4";
      };
      "/var" = {
        label = "mncr-var";
        fsType = "ext4";
      };
      "/mnt/ssdstore" = {
        label = "SSD_2TB";
        fsType = "ext4";
      };
      "/mnt/hddstore" = {
        label = "HDD_12TB";
        fsType = "ext4";
      };
    };
    systemd.tmpfiles.rules = [
      "d /mnt/ssdstore 0755 root root -"
    ];
  };
}
