{inputs, ...}: {
  flake.nixosModules.muncher = {config, ...}: {
    users.users.kerry = {
      isNormalUser = true;
      description = "Kerry Cerqueira";
      extraGroups = ["networkmanager" "wheel"];
      hashedPasswordFile = config.sops.secrets."hashedUserPasswords/kerry".path;
      uid = 1000;
    };
    home-manager.users.kerry = {
      imports = [
        inputs.kc-nix-infra.homeModules."kerry@muncher"
      ];
    };
  };
}
