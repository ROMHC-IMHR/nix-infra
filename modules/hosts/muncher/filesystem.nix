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
      label = "mncr-root";
      fsType = "ext4";
    };
    fileSystems."/boot" = {
      label = "MNCR-BOOT";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
    fileSystems."/home" = {
      label = "mncr-home";
      fsType = "ext4";
    };
    fileSystems."/nix" = {
      label = "mncr-nix";
      fsType = "ext4";
    };
    fileSystems."/var" = {
      label = "mncr-var";
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
