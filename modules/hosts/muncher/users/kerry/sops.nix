{...}: {
  flake.homeModules."kerry@muncher" = {
    config,
    pkgs,
    ...
  }: {
    # sops = {
    #   defaultSopsFile = ./secrets.yaml;
    #   defaultSopsFormat = "yaml";
    #   age.sshKeyPaths = ["{config.home.homeDirectory}/.ssh/id_ed25519"];
    #   secrets = {
    #   };
    # };
  };
}
