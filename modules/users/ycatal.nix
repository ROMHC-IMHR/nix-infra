{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "ycatal")];
    users.users."ycatal" = {
      isNormalUser = true;
      description = "Yasir Çatal";
      uid = 1002;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ+KnB1UZZpv774N74cAoXUbdrTyUx2ejMsGThlDrjZH catalyasir@gmail.com"
      ];
      packages = with pkgs; [
        uv
      ];
    };
  };
}
