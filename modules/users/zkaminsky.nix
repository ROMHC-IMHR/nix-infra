{self, ...}: {
  flake.nixosModules.zkaminsky = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "zkaminsky")];
    users.users."zkaminsky" = {
      isNormalUser = true;
      description = "Zachary Kaminsky";
      uid = 1008;
      packages = with pkgs; [
        uv
      ];
    };
  };
  deployments.nixosModules.zkaminsky = ["muncher"];
}
