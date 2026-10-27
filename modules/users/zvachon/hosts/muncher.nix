{self, ...}: {
  flake.nixosModules.zvachon-muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "zvachon")];
    users.users."zvachon" = {
      isNormalUser = true;
      description = "Zachary Vachon";
      uid = self.lib.constants.uids.zvachon;
      packages = with pkgs; [uv];
    };
    systemd.slices."user-${toString config.users.users.zvachon.uid}" = {
      overrideStrategy = "asDropin";
      sliceConfig = {
        DevicePolicy = "closed";
        DeviceAllow = [
          "char-pts rw"
          "/dev/nvidiactl rw"
          "/dev/nvidia-uvm rw"
          "/dev/nvidia-uvm-tools rw"
          "/dev/nvidia1 rw"
        ];
        MemoryHigh = "112G";
        MemoryMax = "128G";
        MemorySwapMax = 0;
        TasksMax = 16384;
      };
    };
  };
  deployments.nixosModules.zvachon-muncher = ["muncher"];
}
