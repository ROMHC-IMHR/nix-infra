{self, ...}: {
  flake.nixosModules.ltuominen-muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "ltuominen")];
    users.users."ltuominen" = {
      isNormalUser = true;
      description = "Lauri Tuominen";
      uid = self.lib.constants.uids.ltuominen;
      packages = with pkgs; [
        uv
      ];
    };
  };
  deployments.nixosModules.ltuominen-muncher = ["muncher"];
}
