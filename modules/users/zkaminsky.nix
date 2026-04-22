{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: let
    userParams = {
      username = "zkaminsky";
      fullname = "Zachary Kaminsky";
      uid = 1008;
      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILBqVp29LND+YsUimF/Gm+LdfU8jdc8xea/HBIDXwA0D zacharykaminsky@gmail.com"
      ];
      extraPkgs = with pkgs; [uv];
    };
  in {
    imports = [(self.lib.muncherUser userParams)];
  };
}
