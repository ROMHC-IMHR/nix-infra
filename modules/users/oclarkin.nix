{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "oclarkin")];
    users.users."oclarkin" = {
      isNormalUser = true;
      description = "Owen Clarkin";
      uid = 1006;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBnWTlXs/DFDuUWLcsdzqSK6tlzbRzjd0VMkOh8XvqRz Owen.Clarkin@theroyal.ca"
      ];
      packages = with pkgs; [
        uv
      ];
    };
  };
}
