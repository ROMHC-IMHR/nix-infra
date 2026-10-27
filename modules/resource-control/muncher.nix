# Resource control on muncher: services outrank interactive users for CPU,
# and service memory (including page cache holding model weights) is
# protected from reclaim.
{
  flake.nixosModules.muncher = {
    systemd.slices = {
      # cgroup v2 weights only compete between siblings, so this ranks all
      # humans below system.slice and machine.slice (both default to 100).
      user = {
        overrideStrategy = "asDropin";
        sliceConfig.CPUWeight = 50;
      };
      # MemoryLow protects usage below the value from reclaim while anything
      # else can be reclaimed instead. systemd mounts cgroup2 with
      # memory_recursiveprot, so protection flows down to every service.
      system = {
        overrideStrategy = "asDropin";
        sliceConfig.MemoryLow = "24G";
      };
      # Rootful podman containers live here.
      machine = {
        overrideStrategy = "asDropin";
        sliceConfig.MemoryLow = "24G";
      };
    };
  };
}
