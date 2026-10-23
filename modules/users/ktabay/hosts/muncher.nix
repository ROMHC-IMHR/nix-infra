{self, ...}: {
  flake.nixosModules.ktabay-muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "ktabay")];
    users.users."ktabay" = {
      isNormalUser = true;
      description = "Konrad Tabay";
      uid = self.lib.constants.uids.ktabay;
      packages = with pkgs; [
        uv
      ];
    };
  };
  deployments.nixosModules.ktabay-muncher = ["muncher"];
}
