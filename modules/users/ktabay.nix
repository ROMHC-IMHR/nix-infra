{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "ktabay")];
    users.users."ktabay" = {
      isNormalUser = true;
      description = "Konrad Tabay";
      uid = 1001;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIALZTjLj4W3UVEw6u3bEhykcGmpxeuuqhOQED20+Zx5q"
      ];
      packages = with pkgs; [
        uv
      ];
    };
  };
}
