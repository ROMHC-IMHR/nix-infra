{inputs, ...}: {
  flake.nixosModules.muncher = {config, ...}: {
    users.users.kerry = {
      isNormalUser = true;
      description = "Kerry Cerqueira";
      extraGroups = ["networkmanager" "wheel"];
      uid = 1000;
    };
    home-manager.users.kerry = {
      imports = [
        inputs.kc-nix-infra.homeModules."kerry@muncher"
      ];
    };
    fileSystems."/home/kerry/ssd" = {
      device = "/mnt/ssdstore/users/kerry";
      options = ["bind"];
      depends = ["/mnt/ssdstore"];
    };
    fileSystems."/home/kerry/hdd" = {
      device = "/mnt/hddstore/users/kerry";
      options = ["bind"];
      depends = ["/mnt/hddstore"];
    };
    systemd.tmpfiles.rules = [
      "d /mnt/ssdstore/users/kerry 0700 kerry users -"
      "d /home/kerry/ssd 0700 kerry users -"
      "d /mnt/hddstore/users/kerry 0700 kerry users -"
      "d /home/kerry/hdd 0700 kerry users -"
    ];
  };
}
