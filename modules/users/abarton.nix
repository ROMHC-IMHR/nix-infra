{self, ...}: {
  flake.nixosModules.abarton = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "abarton")];
    users.users."abarton" = {
      isNormalUser = true;
      description = "Alex Barton";
      uid = 1005;
      packages = with pkgs; [
        uv
      ];
    };
  };
  deployments.nixosModules.abarton = ["muncher"];
}
