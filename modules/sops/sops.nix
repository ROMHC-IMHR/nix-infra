{
  inputs,
  lib,
  ...
}: let
  sops-common = {
    sops = {
      age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    };
  };
in {
  flake.nixosModules =
    lib.genAttrs [
      "scruncher"
      "muncher"
    ] (host: {
      imports = [
        sops-common
        inputs.sops-nix.nixosModules.sops
      ];
      sops = {
        defaultSopsFile = ./secrets/${host}.yaml;
        defaultSopsFormat = "yaml";
      };
    });
}
