{self, ...}: {
  flake.nixosModules.fdjimbouon-muncher = {
    config,
    pkgs,
    ...
  }: {
    users.users."fdjimbouon" = {
      isNormalUser = true;
      description = "Frank Djimbouon";
      uid = self.lib.constants.uids.fdjimbouon;
      packages = with pkgs; [uv];
    };
    imports = [(self.lib.muncherUserBindMounts "fdjimbouon")];
  };
  deployments.nixosModules.fdjimbouon-muncher = ["muncher"];
}
