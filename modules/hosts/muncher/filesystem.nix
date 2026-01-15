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
      device = "crnr-home";
      fsType = "ext4";
    };
  };
}
