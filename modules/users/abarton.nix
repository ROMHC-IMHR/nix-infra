{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: let
    userParams = {
      username = "abarton";
      fullname = "Alex Barton";
      uid = 1005;
      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLDnX1oNXUBxdxNR21a4FDfSoMIJfSWlIX1KmsAUl6Q"
      ];
      extraPkgs = with pkgs; [uv];
    };
  in {
    imports = [(self.lib.muncherUser userParams)];
  };
}
