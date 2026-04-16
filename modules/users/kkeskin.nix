{self, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: let
    userParams = {
      username = "kkeskin";
      fullname = "Kaan Keskin";
      uid = 1007;
      sshKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII4VHHWBSjs8+PaEBLxBpuAK+VynrW6Zdu96ETiZVKu/ kaanka5312@gmail.com"
      ];
      extraPkgs = with pkgs; [uv];
    };
  in {
    imports = [(self.lib.muncherUser userParams)];
  };
}
