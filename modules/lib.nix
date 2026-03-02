{
  flake.lib = {
    muncherUser = {
      username,
      fullname,
      uid,
      sshKeys,
      extraPkgs ? [],
    }: let
      hddPath = "/mnt/hddstore/users/${username}";
      hddHomePath = "/home/${username}/hdd";
      ssdPath = "mnt/ssdstore/users/${username}";
      ssdHomePath = "/home/${username}/ssd";
    in
      {pkgs, ...}: {
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
  };
}
