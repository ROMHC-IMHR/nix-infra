{inputs, ...}: {
  flake.nixosModules.muncher = {pkgs, ...}: let
    mineruRepo = pkgs.fetchFromGitHub {
      owner = "opendatalab";
      repo = "MinerU";
      rev = "master";
      hash = pkgs.lib.fakeHash;
    };
  in {
    virtualisation.arion.projects.mineru.settings = {
      services.mineru = {
        build.context = "${mineruRepo}/docker/global";
        build.dockerfile = "Dockerfile";
        service.ports = ["5000:5000"];
        service.command = ["mineru-api" "--host" "0.0.0.0" "--port" "5000"];
        service.environment = {
          MINERU_MODEL_SOURCE = "local";
        };
        service.deploy.resources.reservations.devices = [
          {
            driver = "nvidia";
            count = "all";
            capabilities = ["gpu"];
          }
        ];
        service.shm_size = "16gb";
        service.volumes = [
          "/mnt/ssdstore/containers/mineru/models:/root/.cache"
        ];
      };
    };
  };
}
