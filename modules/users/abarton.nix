{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "abarton")];
    users.users."abarton" = {
      isNormalUser = true;
      description = "Alex Barton";
      uid = 1005;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLDnX1oNXUBxdxNR21a4FDfSoMIJfSWlIX1KmsAUl6Q"
      ];
      packages = with pkgs; [
        uv
      ];
    };
  };
}
