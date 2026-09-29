{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "chonderich")];
    users.users."chonderich" = {
      isNormalUser = true;
      description = "Claire Honderich";
      uid = 1010;
      packages = with pkgs; [
        uv
      ];
    };
  };
}
