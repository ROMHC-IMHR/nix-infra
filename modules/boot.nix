{inputs, ...}: {
  flake.nixosModules = {
    boot.boot.loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        editor = false;
        consoleMode = "max";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    lanzaboote = {lib, ...}: {
      imports = [inputs.lanzaboote.nixosModules.lanzaboote];
      boot = {
        loader.systemd-boot.enable = lib.mkForce false;
        lanzaboote = {
          enable = true;
          pkiBundle = "/var/lib/sbctl";
        };
      };
    };
  };
  deployments.nixosModules = {
    boot = [
      "lanzaboote"
      "scruncher"
    ];
    lanzaboote = [];
  };
}
