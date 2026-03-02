{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: let
    userParams = {
      username = "ycatal";
      fullname = "Yasir Çatal";
      uid = 1002;
      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ+KnB1UZZpv774N74cAoXUbdrTyUx2ejMsGThlDrjZH catalyasir@gmail.com"
      ];
      extraPkgs = with pkgs; [uv];
    };
  in {
    imports = [(self.lib.muncherUser userParams)];
  };
}
