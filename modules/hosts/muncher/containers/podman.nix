{inputs, ...}: {
  flake.nixosModules.muncher = {
    imports = [inputs.arion.nixosModules.arion];
    virtualisation.podman.enable = true;
    virtualisation.arion.enable = true;
    virtualisation.arion.backend = "podman-socket";
    virtualisation.oci-containers.backend = "podman";
    virtualisation.containers.containersConf.settings = {
      engine = {
        env = [ "TMPDIR=/mnt/ssdstore/containers/tmp" ];
      };
    };
    virtualisation.containers.storage.settings = {
      storage = {
        graphroot = "/mnt/ssdstore/containers";
      };
    };
  };
}
