{
  flake.nixosModules.common-shell = {pkgs, ...}: {
    programs = {
      zsh.enable = true;
      fish.enable = true;
      direnv = {
        enable = true;
        silent = false;
        nix-direnv.enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
      };
    };
    users.defaultUserShell = pkgs.fish;
    users.users.root.shell = pkgs.bash;
    environment.systemPackages = with pkgs; [
      git
      curl
      wget
      rsync
      unzip
      zip
      gnutar
      file
      which
      tmux
      screen
      kitty.terminfo
    ];
  };
  deployments.nixosModules.common-shell = [
    "muncher"
    "scruncher"
  ];
}
