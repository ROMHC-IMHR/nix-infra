let
  username = "ktabay";
  fullname = "Konrad Tabay";
  sshKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJSimJGwX8BKJmip04XakVzcjl39tD09vNICeIK5lO0S"
  ];
in {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: let
    hddPath = "/mnt/hddstore/users/${username}";
    hddHomePath = "/home/${username}/hdd";
    ssdPath = "mnt/ssdstore/users/${username}";
    ssdHomePath = "/home/${username}/ssd";
  in {
    users.users."${username}" = {
      isNormalUser = true;
      description = fullname;
      uid = 1001;
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
