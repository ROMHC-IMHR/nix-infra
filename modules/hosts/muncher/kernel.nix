{
  flake.nixosModules.muncher = {
    config,
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
    };
  };
}
