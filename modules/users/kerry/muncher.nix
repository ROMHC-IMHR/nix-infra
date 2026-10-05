{self, ...}: {
  flake.nixosModules.kerry-muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "kerry")];
    users.users.kerry = {
      extraGroups = ["networkmanager" "wheel"];
      uid = 1000;
    };
    home-manager.users.kerry = self.homeModules.kerry-muncher;
  };
  deployments.nixosModules.kerry-muncher = ["muncher"];
}
