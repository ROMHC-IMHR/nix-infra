{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.muncher = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      (self.lib.muncherUserBindMounts "kerry")
    ];
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
    home-manager.users.kerry = {imports = [self.homeModules."kerry@muncher"];};
  };

  flake.homeModules."kerry@muncher" = {
    imports = with inputs.kc-nix-infra.homeModules; [
      neovim
      terminal
    ];
    nixpkgs.config.allowUnfree = true;
    programs.home-manager.enable = true;
    home = {
      stateVersion = "25.11";
      username = "kerry";
      homeDirectory = "/home/kerry";
    };
  };
}
