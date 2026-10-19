{self, ...}: {
  flake.nixosModules.kkeskin-muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "kkeskin")];
    users.users."kkeskin" = {
      isNormalUser = true;
      description = "Kaan Keskin";
      uid = self.lib.constants.uids.kkeskin;
      packages = with pkgs; [uv];
    };
  };
  deployments.nixosModules.kkeskin-muncher = ["muncher"];
}
