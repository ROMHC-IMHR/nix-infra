{
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: let
    username = "ycatal";
    fullname = "Yasir Çatal";
    uid = 1002;
    sshKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ+KnB1UZZpv774N74cAoXUbdrTyUx2ejMsGThlDrjZH catalyasir@gmail.com"
    ];
    hddPath = "/mnt/hddstore/users/${username}";
    hddHomePath = "/home/${username}/hdd";
    ssdPath = "mnt/ssdstore/users/${username}";
    ssdHomePath = "/home/${username}/ssd";
  in {
    users.users."${username}" = {
      isNormalUser = true;
      description = fullname;
      uid = uid;
      openssh.authorizedKeys.keys = sshKeys;
      packages = with pkgs; [
        uv
      ];
    };
    fileSystems."${ssdHomePath}" = {
      device = ssdPath;
      options = ["bind"];
      depends = ["/mnt/ssdstore"];
    };
    fileSystems."${hddHomePath}" = {
      device = hddPath;
      options = ["bind"];
      depends = ["/mnt/hddstore"];
    };
    systemd.tmpfiles.rules = [
      "d ${ssdPath} 0700 ${username} users -"
      "d ${ssdHomePath} 0700 ${username} users -"
      "d ${hddPath} 0700 ${username} users -"
      "d ${hddHomePath} 0700 ${username} users -"
    ];
  };
}
