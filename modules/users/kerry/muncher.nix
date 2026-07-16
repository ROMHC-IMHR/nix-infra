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
    };
    home-manager.users.kerry = {imports = [self.homeModules."kerry@muncher"];};
  };

  flake.homeModules."kerry@muncher" = {pkgs, ...}: {
    imports = with inputs.kc-nix-infra.homeModules; [
      neovim
      terminal
    ];
    nixpkgs.config.allowUnfree = true;
    programs.home-manager.enable = true;
    home = {
      packages = [pkgs.uv];
      username = "kerry";
      homeDirectory = "/home/kerry";
    };
  };
}
