{
  flake.nixosModules.abarton = {
    config,
    pkgs,
    ...
  }: {
    users.users."abarton" = {
      isNormalUser = true;
      description = "Alex Barton";
    };
  };
  deployments.nixosModules.abarton = [
    "abarton-muncher"
    "abarton-scruncher"
  ];
}
