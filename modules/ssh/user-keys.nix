{
  flake.lib.constants.ssh.public-keys = {
    kerry-ed25519 = builtins.readFile ./public-keys/kerry_ed25519.pub;
  };
  flake.nixosModules.muncher = {config, ...}: {
    sops.secrets."ssh/kerry_ed25519" = {
      sopsFile = ./secrets + "/muncher/kerry/ed25519";
      format = "binary";
      owner = "kerry";
      mode = "0400";
      path = "${config.users.users.kerry.home}/.ssh/id_ed25519";
    };
  };
  flake.homeModules.kerry-muncher = {osConfig, ...}: {
    home.file.".ssh/id_ed25519.pub".source =
      ./public-keys/muncher/kerry/ed25519.pub;
    programs.ssh.settings."*".identityFile =
      osConfig.sops.secrets."ssh/kerry_ed25519".path;
  };
}
