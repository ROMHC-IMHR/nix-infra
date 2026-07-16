{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "oclarkin")];
    users.users."oclarkin" = {
      isNormalUser = true;
      description = "Owen Clarkin";
      uid = 1006;
      packages = with pkgs; [
        uv
      ];
    };
  };
}
