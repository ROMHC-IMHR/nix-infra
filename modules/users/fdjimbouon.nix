{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: {
    users.users."fdjimbouon" = {
      isNormalUser = true;
      description = "Frank Djimbouon";
      uid = 1004;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBT8xNZBRzQBdcqWzGS43qeOdJEAZY3gI/2szobl2UYd"
      ];
      packages = with pkgs; [
        uv
      ];
    };
    imports = [(self.lib.muncherUserBindMounts "fdjimbouon")];
  };
}
