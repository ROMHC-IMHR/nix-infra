{self, ...}: {
  flake.nixosModules.oclarkin-muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "oclarkin")];
    users.users."oclarkin" = {
      isNormalUser = true;
      description = "Owen Clarkin";
      uid = self.lib.constants.uids.oclarkin;
      packages = with pkgs; [uv];
    };
  };
  deployments.nixosModules.oclarkin-muncher = ["muncher"];
}
