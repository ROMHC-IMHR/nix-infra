{self, ...}: {
  flake.nixosModules.ltuominen = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "ltuominen")];
    users.users."ltuominen" = {
      isNormalUser = true;
      description = "Lauri Tuominen";
      uid = 1003;
      packages = with pkgs; [
        uv
      ];
    };
  };
  deployments.nixosModules.ltuominen = ["muncher"];
}
