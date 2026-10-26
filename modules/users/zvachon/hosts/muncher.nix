{self, ...}: {
  flake.nixosModules.zvachon-muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "zvachon")];
    users.users."zvachon" = {
      isNormalUser = true;
      description = "Zachary Vachon";
      uid = self.lib.constants.uids.zvachon;
      packages = with pkgs; [uv];
    };
  };
  deployments.nixosModules.zvachon-muncher = ["muncher"];
}
