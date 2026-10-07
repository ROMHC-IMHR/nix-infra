{
  flake.nixosModules.HOSTNAME = {pkgs, ...}: {
    boot = {
      initrd.availableKernelModules = [
        "xhci_pci"
        "ehci_pci"
        "nvme"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [
        "kvm-amd"
        "k10temp"
        "ipmi_si"
        "ipmi_devintf"
      ];
      kernelParams = [
        "iommu=pt"
      ];
    };
    services.xserver.videoDrivers = ["nvidia"];
    hardware = {
      cpu.amd.updateMicrocode = true;
      enableRedistributableFirmware = true;
      graphics.enable = true;
      nvidia = {
        open = true;
        branch = "production";
        nvidiaSettings = false;
        nvidiaPersistenced = true;
      };
    };
    environment.systemPackages = with pkgs; [
      nvtopPackages.nvidia
      pciutils
      hwloc
      numactl
      dmidecode
      ethtool
      lm_sensors
      nvme-cli
      smartmontools
      ipmitool
      redfishtool
    ];
  };
}
