{...}: {
  flake.nixosModules.muncher = {pkgs, ...}: let
    mineruRepo = pkgs.fetchFromGitHub {
      owner = "opendatalab";
      repo = "MinerU";
      rev = "a12610fb3e9e24488fe3e76cd233ba88ec64bbaf";
      hash = "sha256-sSXb8QxtnlDV/5Vba/nvKO414r9eNzZs2WILNvRxi+U=";
    };
  in {
    hardware.nvidia-container-toolkit.enable = true;
    virtualisation.arion.projects.mineru.settings = {
      docker-compose.raw = {
        services.mineru = {
          shm_size = "16gb";
        };
      };
      services.mineru = {
        service.devices = [
          "nvidia.com/gpu=all"
        ];
        service.build.context = "${mineruRepo}/docker/global";
        service.build.dockerfile = "Dockerfile";
        service.ports = ["5000:5000"];
        service.command = [
          "mineru-api"
          "--host"
          "0.0.0.0"
          "--port"
          "5000"
          "--gpu-memory-utilization"
          "0.15"
        ];
        service.environment = {
          MINERU_MODEL_SOURCE = "local";
        };
      };
    };
  };
}
