{self, ...}: {
  flake.nixosModules.mzhang = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "mzhang")];
    users.users."mzhang" = {
      isNormalUser = true;
      description = "Mengfang Zhang";
      uid = 1009;
    };
  };
  deployments.nixosModules.mzhang = ["muncher"];
}
