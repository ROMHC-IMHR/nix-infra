{self, ...}: {
  flake.nixosModules.abarton-scruncher = {
    users.users."abarton".uid = self.lib.constants.uids.abarton;
  };
  deployments.nixosModules.abarton-scruncher = ["scruncher"];
}
