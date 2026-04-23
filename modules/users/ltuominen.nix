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
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMM9X/iXoemi+CVRkdkN9I4F1JbAhD8X4+WS6eD7tAzZ tuominenlj@gmail.com"
      ];
      packages = with pkgs; [
        uv
      ];
    };
  };
}
