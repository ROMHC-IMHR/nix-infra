{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "zkaminsky")];
    users.users."zkaminsky" = {
      isNormalUser = true;
      description = "Zachary Kaminsky";
      uid = 1008;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILBqVp29LND+YsUimF/Gm+LdfU8jdc8xea/HBIDXwA0D zacharykaminsky@gmail.com"
      ];
      packages = with pkgs; [
        uv
      ];
    };
  };
}
