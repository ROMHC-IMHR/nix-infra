{inputs, ...}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: {
    users.users.kerry = {
      isNormalUser = true;
      description = "Kerry Cerqueira";
      extraGroups = ["networkmanager" "wheel"];
      uid = 1000;
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtCFAEnUE/6pRWjylYWqAgsfswF0GTlK04ZKMjWNiZn kerry@claudius"
      ];
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
