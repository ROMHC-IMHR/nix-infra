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
  };
}
