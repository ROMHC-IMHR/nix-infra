{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: let
    userParams = {
      username = "ktabay";
      fullname = "Konrad Tabay";
      uid = 1001;
      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJSimJGwX8BKJmip04XakVzcjl39tD09vNICeIK5lO0S"
      ];
      extraPkgs = with pkgs; [uv];
    };
  in {
    imports = [(self.lib.muncherUser userParams)];
  };
}
