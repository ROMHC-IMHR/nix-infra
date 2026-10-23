{self, ...}: {
  flake.nixosModules.mzhang-muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "mzhang")];
    users.users."mzhang".uid = self.lib.constants.uids.mzhang;
  };
  deployments.nixosModules.mzhang-muncher = ["muncher"];
}
