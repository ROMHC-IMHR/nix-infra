{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [(self.lib.muncherUserBindMounts "kkeskin")];
    users.users."kkeskin" = {
      isNormalUser = true;
      description = "Kaan Keskin";
      uid = 1007;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII4VHHWBSjs8+PaEBLxBpuAK+VynrW6Zdu96ETiZVKu/ kaanka5312@gmail.com"
      ];
      packages = with pkgs; [
        uv
      ];
    };
  };
}
