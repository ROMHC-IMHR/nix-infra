{inputs, ...}: {
  flake.nixosModules.muncher = {
    config,
    lib,
    ...
  }: {
    containers.docling = {
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
      };
      config = {pkgs, ...}: {
        hardware.graphics.enable = true;
        services.docling-serve = {
          enable = true;
          port = 5001;
          host = "0.0.0.0";
        };
        # system.stateVersion = "26.05";
      };
      nixpkgs = inputs.docling-nixpkgs;
      privateNetwork = false;
    };
  };
}
