{
  flake.nixosModules.muncher = {pkgs, ...}: {
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
    users.defaultUserShell = pkgs.zsh;
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
}
