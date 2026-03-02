{inputs, ...}: {
  flake.nixosModules.muncher = {
    imports = [inputs.arion.nixosModules.arion];
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    virtualisation.arion.backend = "podman-socket";
    virtualisation.oci-containers.backend = "podman";
    virtualisation.containers.storage.settings = {
      storage = {
        graphroot = "/mnt/ssdstore/containers";
      };
    };
  };
}
