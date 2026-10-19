{self, ...}: {
  flake.nixosModules.ycatal-muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "ycatal")];
    users.users."ycatal" = {
      isNormalUser = true;
      description = "Yasir Çatal";
      uid = self.lib.constants.uids.ycatal;
      packages = with pkgs; [uv];
    };
  };
  deployments.nixosModules.ycatal-muncher = ["muncher"];
}
