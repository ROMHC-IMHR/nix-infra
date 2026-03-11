{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: let
    userParams = {
      username = "oclarkin";
      fullname = "Owen Clarkin";
      uid = 1006;
      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBnWTlXs/DFDuUWLcsdzqSK6tlzbRzjd0VMkOh8XvqRz Owen.Clarkin@theroyal.ca"
      ];
    };
  in {
    imports = [(self.lib.muncherUser userParams)];
  };
}
