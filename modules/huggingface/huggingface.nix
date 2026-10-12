{lib, ...}: {
  flake = {
    nixosModules =
      lib.genAttrs [
        "scruncher"
        "muncher"
      ] (host: {config, ...}: let
        kerry = config.users.users.kerry;
      in {
        sops.secrets.hfToken = {
          path = "${kerry.home}/.cache/huggingface/token";
          sopsFile = ./secrets/${host}/token;
          format = "binary";
          owner = "kerry";
          mode = "0400";
        };
      });
    homeModules.huggingface = {pkgs, ...}: {
      home.packages = [pkgs.python314Packages.huggingface-hub];
    };
  };
  deployments.homeModules.huggingface = ["kerry-scruncher"];
}
