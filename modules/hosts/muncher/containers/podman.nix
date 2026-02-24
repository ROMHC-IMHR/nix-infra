{...}: {
  flake.nixosModules.muncher = {
    virtualisation.podman.enable = true;
    virtualisation.oci-containers.backend = "podman";
    virtualisation.containers.storage.settings = {
      storage = {
        graphroot = "/mnt/ssdstore/containers";
      };
    };
  };
}
