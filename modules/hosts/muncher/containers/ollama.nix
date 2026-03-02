{inputs, ...}: {
  flake.nixosModules.muncher = {
    config,
    lib,
    pkgs,
    ...
  }: let
    ollamaDataDir = "/mnt/ssdstore/ollama";
    ollamaUid = 994;
    ollamaGid = 992;
    ollamaUser = {
      isSystemUser = true;
      group = "ollama";
      description = "Ollama Service User";
      uid = ollamaUid;
    };
    ollamaGroup = {
      gid = ollamaGid;
    };
  in {
    containers.ollama = {
      autoStart = true;
      privateNetwork = false;
      bindMounts = {
        "/var/lib/ollama" = {
          hostPath = ollamaDataDir;
          isReadOnly = false;
        };
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
      };
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
      nixpkgs = inputs.ollama-nixpkgs;
      config = {pkgs, ...}: {
        system.stateVersion = "26.05";
        nixpkgs.config = {
          allowUnfree = true;
          cudaSupport = true;
        };
        services.ollama = {
          enable = true;
          environmentVariables = {
            OLLAMA_NUM_PARALLEL = "4";
            OLLAMA_FLASH_ATTENTION = "1";
          };
          package = pkgs.ollama-cuda;
          host = "127.0.0.1";
          port = 11434;
          user = "ollama";
          group = "ollama";
        };
        users = {
          users.ollama = ollamaUser;
          groups.ollama = ollamaGroup;
        };
        systemd = {
          services.ollama.serviceConfig = {
            DynamicUser = lib.mkForce false;
            User = "ollama";
            ReadWritePaths = ["/var/lib/ollama"];
          };
        };
      };
    };
    systemd = {
      tmpfiles.rules = [
        "d ${ollamaDataDir} 0755 ollama ollama -"
      ];
    };
    users = {
      users.ollama = ollamaUser;
      groups.ollama = ollamaGroup;
    };
  };
}
