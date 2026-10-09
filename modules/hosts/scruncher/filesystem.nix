{inputs, ...}: {
  flake.nixosModules.scruncher = {config, ...}: {
    imports = [inputs.disko.nixosModules.disko];
    assertions = [
      {
        assertion = config.boot.initrd.systemd.enable;
        message = "scruncher: TPM2 crypttab options require systemd stage-1 (boot.initrd.systemd.enable = true)";
      }
    ];
    boot.initrd = {
      luks.devices = let
        tpm = [
          "tpm2-device=auto"
          "tpm2-measure-pcr=yes"
        ];
      in {
        cryptroot.crypttabExtraOpts = tpm;
        cryptdata0.crypttabExtraOpts = tpm;
        cryptdata1.crypttabExtraOpts = tpm;
      };
    };
    zramSwap = {
      enable = true;
      priority = 100;
      algorithm = "zstd";
      memoryPercent = 25;
    };
    disko.devices.disk = {
      scruncher-boot = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-HPE_NS204i-u_Gen11_Boot_Controller_PYWWA0A6KMN2UA";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                settings.allowDiscards = true;
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = {
                    "@" = {
                      mountpoint = "/";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                    "@var" = {
                      mountpoint = "/var";
                      mountOptions = ["compress=zstd" "noatime"];
                    };
                  };
                };
              };
            };
          };
        };
      };
      scruncher-data0 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-VO003840KYWYP_S87LNC0L502367";
        content = {
          type = "gpt";
          partitions.data = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptdata0";
              settings.allowDiscards = true;
            };
          };
        };
      };
      scruncher-data1 = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-VO003840KYWYP_S87LNC0L502368";
        content = {
          type = "gpt";
          partitions.data = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptdata1";
              settings.allowDiscards = true;
              content = {
                type = "btrfs";
                extraArgs = [
                  "-f"
                  "-d raid0"
                  "-m raid1"
                  "/dev/mapper/cryptdata0"
                ];
                subvolumes."@nix" = {
                  mountpoint = "/nix";
                  mountOptions = ["compress=zstd" "noatime"];
                };
              };
            };
          };
        };
      };
    };
  };
}
