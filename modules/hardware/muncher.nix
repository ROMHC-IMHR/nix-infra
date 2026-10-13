{
  flake.nixosModules.muncher = {
    config,
    pkgs,
    lib,
    ...
  }: {
    boot = {
      initrd.availableKernelModules = ["xhci_pci" "ahci" "vmd" "nvme" "usbhid"];
      kernelModules = ["kvm-intel"];
      loader = {
        systemd-boot.enable = false;
        grub = {
          enable = true;
          device = "nodev";
          efiSupport = true;
        };
        efi.canTouchEfiVariables = true;
      };
    };
    hardware = {
      cpu.intel.updateMicrocode = true;
      enableRedistributableFirmware = true;
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      nvidia = {
        modesetting.enable = true;
        open = false;
        nvidiaSettings = false;
        package = config.boot.kernelPackages.nvidiaPackages.production;
      };
    };
    services.xserver.videoDrivers = ["nvidia"];
    environment.systemPackages = with pkgs; [
      nvtopPackages.nvidia
      clinfo
    ];
  };
}
