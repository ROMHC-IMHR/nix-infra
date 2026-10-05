{inputs, ...}: {
  flake = {
    nixosModules.kerry = {
      config,
      pkgs,
      ...
    }: {
      users.users.kerry = {
        isNormalUser = true;
        description = "Kerry Cerqueira";
        shell = pkgs.fish;
      };
    };
    homeModules.kerry = {pkgs, ...}: {
      imports = with inputs.kc-nix-infra.homeModules; [
        neovim
        terminal
      ];
      nixpkgs.config.allowUnfree = true;
      programs.home-manager.enable = true;
      home.packages = [pkgs.uv];
    };
  };
  deployments = {
    nixosModules.kerry = [
      "kerry-muncher"
      "kerry-scruncher"
    ];
    homeModules.kerry = [
      "kerry-muncher"
      "kerry-scruncher"
    ];
  };
}
