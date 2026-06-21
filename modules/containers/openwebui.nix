{inputs, ...}: {
  flake.nixosModules.muncher = let
    owuiStateDir = "/mnt/ssdstore/open-webui";
    owuiUid = 995;
    owuiGid = 993;
    owuiUser = {
      isSystemUser = true;
      group = "open-webui";
      description = "Open WebUI Service User";
      uid = owuiUid;
    };
    owuiGroup = {
      gid = owuiGid;
    };
  in
    {
      config,
      lib,
      ...
    }: {
      containers.open-webui = {
        allowedDevices = [
          {
            node = "/dev/nvidia0";
            modifier = "rw";
          }
          {
            node = "/dev/nvidia1";
            modifier = "rw";
          }
          {
            node = "/dev/nvidiactl";
            modifier = "rw";
          }
          {
            node = "/dev/nvidia-uvm";
            modifier = "rw";
          }
          {
            node = "/dev/nvidia-uvm-tools";
            modifier = "rw";
          }
        ];
        autoStart = true;
        privateNetwork = false;
        bindMounts = {
          "/dev/nvidia0" = {
            hostPath = "/dev/nvidia0";
            isReadOnly = false;
          };
          "/dev/nvidia1" = {
            hostPath = "/dev/nvidia1";
            isReadOnly = false;
          };
          "/dev/nvidiactl" = {
            hostPath = "/dev/nvidiactl";
            isReadOnly = false;
          };
          "/dev/nvidia-uvm" = {
            hostPath = "/dev/nvidia-uvm";
            isReadOnly = false;
          };
          "/dev/nvidia-uvm-tools" = {
            hostPath = "/dev/nvidia-uvm-tools";
            isReadOnly = false;
          };
          "/run/opengl-driver" = {
            hostPath = "/run/opengl-driver";
            isReadOnly = true;
          };
          "/proc/driver/nvidia" = {
            hostPath = "/proc/driver/nvidia";
            isReadOnly = true;
          };
          "/var/lib/open-webui" = {
            hostPath = owuiStateDir;
            isReadOnly = false;
          };
          "/run/secrets/openwebui/environment" = {
            hostPath = config.sops.secrets."openwebui/environment".path;
            isReadOnly = true;
          };
        };
        nixpkgs = inputs.owui-nixpkgs;
        config = {pkgs, ...}: {
          nixpkgs.config = {
            allowUnfree = true;
            cudaSupport = true;
          };
          services.open-webui = {
            enable = true;
            port = 8080;
            host = "0.0.0.0";
            environment = {
              ENABLE_VERSION_UPDATE_CHECK = "False";
              ANONYMIZED_TELEMETRY = "False";
              DO_NOT_TRACK = "True";
              SCARF_NO_ANALYTICS = "True";
              OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
              ENABLE_SIGNUP = "True";
              DEFAULT_USER_ROLE = "pending";
              USE_CUDA_DOCKER = "True";
            };
            environmentFile = "/run/secrets/openwebui/environment";
          };
          system.stateVersion = "26.05";
          users = {
            users.open-webui = owuiUser;
            groups.open-webui = owuiGroup;
          };
          systemd = {
            services.open-webui.serviceConfig = {
              DynamicUser = lib.mkForce false;
              User = "open-webui";
              ReadWritePaths = ["/var/lib/open-webui"];
            };
          };
        };
      };
      networking.firewall.allowedTCPPorts = [8080];
      sops.secrets = {
        "openwebui/environment" = {
          owner = "open-webui";
          group = "open-webui";
          mode = "0400";
          restartUnits = ["container@open-webui.service"];
        };
      };
      systemd.tmpfiles.rules = [
        "d ${owuiStateDir} 0700 open-webui open-webui -"
      ];
      users = {
        users.open-webui = owuiUser;
        groups.open-webui = owuiGroup;
      };
    };
}
