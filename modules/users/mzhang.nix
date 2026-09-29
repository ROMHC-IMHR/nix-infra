{self, ...}: {
  flake.nixosModules.muncher = {
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
}
