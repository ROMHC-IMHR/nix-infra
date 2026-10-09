{inputs, ...}: let
  sops-common = {
    sops = {
      age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    };
  };
in {
  flake.nixosModules = {
    sops.imports = [
      sops-common
      inputs.sops-nix.nixosModules.sops
    ];
  };
  deployments.nixosModules.sops = [
    "scruncher"
    "muncher"
  ];
}
