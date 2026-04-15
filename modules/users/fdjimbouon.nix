{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: let
    userParams = {
      username = "fdjimbouon";
      fullname = "Frank Djimbouon";
      uid = 1004;
      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBT8xNZBRzQBdcqWzGS43qeOdJEAZY3gI/2szobl2UYd"
      ];
      extraPkgs = with pkgs; [uv];
    };
  in {
    imports = [(self.lib.muncherUser userParams)];
  };
}
