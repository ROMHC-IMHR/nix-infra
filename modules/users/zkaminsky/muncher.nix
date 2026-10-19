{self, ...}: {
  flake.nixosModules.zkaminsky-muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "zkaminsky")];
    users.users."zkaminsky" = {
      isNormalUser = true;
      description = "Zachary Kaminsky";
      uid = self.lib.constants.uids.zkaminsky;
      packages = with pkgs; [uv];
    };
  };
  deployments.nixosModules.zkaminsky-muncher = ["muncher"];
}
