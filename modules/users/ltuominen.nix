{self, ...}: {
  flake.nixosModules.muncher = {
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
}
