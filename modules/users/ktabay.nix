{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "ktabay")];
    users.users."ktabay" = {
      isNormalUser = true;
      description = "Konrad Tabay";
      uid = 1001;
      packages = with pkgs; [
        uv
      ];
    };
  };
}
