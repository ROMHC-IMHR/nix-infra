{
  flake.nixosModules.muncher = {pkgs, ...}: {
    programs.zsh.enable = true;
    programs.fish.enable = true;
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
    ];
  };
}
