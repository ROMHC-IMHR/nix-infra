{self, ...}: {
  flake.nixosModules.ycatal = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "ycatal")];
    users.users."ycatal" = {
      isNormalUser = true;
      description = "Yasir Çatal";
      uid = 1002;
      packages = with pkgs; [
        uv
      ];
    };
  };
  deployments.nixosModules.ycatal = ["muncher"];
}
