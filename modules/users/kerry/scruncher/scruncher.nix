{self, ...}: {
  flake.nixosModules.kerry-scruncher = {
    config,
    pkgs,
    ...
  }: {
    users.users.kerry = {
      extraGroups = ["networkmanager" "wheel"];
      uid = 1000;
    };
    home-manager.users.kerry = self.homeModules.kerry-scruncher;
  };
  deployments.nixosModules.kerry-scruncher = ["scruncher"];
}
