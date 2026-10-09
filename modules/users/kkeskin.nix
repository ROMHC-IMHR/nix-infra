{self, ...}: {
  flake.nixosModules.kkeskin = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "kkeskin")];
    users.users."kkeskin" = {
      isNormalUser = true;
      description = "Kaan Keskin";
      uid = 1007;
      packages = with pkgs; [
        uv
      ];
    };
  };
  deployments.nixosModules.kkeskin = ["muncher"];
}
