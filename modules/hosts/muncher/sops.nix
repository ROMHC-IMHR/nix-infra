{...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: {
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.sshKeyPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
      ];
      secrets = {
        "sshKeys/kerry/public" = {
          path = "/home/kerry/.ssh/id_ed25519.pub";
          owner = "kerry";
        };
        "sshKeys/kerry/private" = {
          path = "/home/kerry/.ssh/id_ed25519";
          owner = "kerry";
        };
      };
    };
  };
}
