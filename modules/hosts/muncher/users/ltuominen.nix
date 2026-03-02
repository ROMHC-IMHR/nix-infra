{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: let
    userParams = {
      username = "ltuominen";
      fullname = "Lauri Tuominen";
      uid = 1003;
      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMM9X/iXoemi+CVRkdkN9I4F1JbAhD8X4+WS6eD7tAzZ tuominenlj@gmail.com"
      ];
    };
  in {
    imports = [(self.lib.muncherUser userParams)];
  };
}
