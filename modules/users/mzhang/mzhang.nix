{
  flake.nixosModules.mzhang = {
    users.users."mzhang" = {
      isNormalUser = true;
      description = "Mengfang Zhang";
    };
  };
  deployments.nixosModules.mzhang = [
    "mzhang-muncher"
    "mzhang-scruncher"
  ];
}
