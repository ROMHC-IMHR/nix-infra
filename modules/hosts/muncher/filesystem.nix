{
  flake.nixosModules.muncher = {
    services.fstrim.enable = true;
    zramSwap = {
      enable = true;
      priority = 100;
      algorithm = "zstd";
      memoryPercent = 25;
    };
    fileSystems."/" = {
      label = "crnr-root";
      fsType = "ext4";
    };
    fileSystems."/boot" = {
      label = "CRNR-BOOT";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
    fileSystems."/home" = {
      label = "crnr-home";
      fsType = "ext4";
    };
    fileSystems."/nix" = {
      label = "crnr-nix";
      fsType = "ext4";
    };
    fileSystems."/mnt/ssdstore" = {
      label = "SSD_2TB";
      fsType = "ext4";
    };
    fileSystems."/mnt/hddstore" = {
      label = "HDD_12TB";
      fsType = "ext4";
    };
    systemd.tmpfiles.rules = [
      "d /mnt/ssdstore 0755 root root -"
    ];
  };
}
