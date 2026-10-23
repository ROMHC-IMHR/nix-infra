{self, ...}: {
  flake.nixosModules.chonderich-muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "chonderich")];
    users.users."chonderich" = {
      isNormalUser = true;
      description = "Claire Honderich";
      uid = self.lib.constants.uids.chonderich;
      packages = with pkgs; [
        uv
      ];
    };
  };
  deployments.nixosModules.chonderich-muncher = ["muncher"];
}
