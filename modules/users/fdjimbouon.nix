{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: {
    users.users."fdjimbouon" = {
      isNormalUser = true;
      description = "Frank Djimbouon";
      uid = 1004;
      packages = with pkgs; [
        uv
      ];
    };
    imports = [(self.lib.muncherUserBindMounts "fdjimbouon")];
  };
}
