{self, ...}: {
  flake.nixosModules.abarton-muncher = {
    imports = [(self.lib.muncherUserBindMounts "abarton")];
    users.users."abarton".uid = self.lib.constants.uids.abarton;
  };
  deployments.nixosModules.abarton-muncher = ["muncher"];
}
