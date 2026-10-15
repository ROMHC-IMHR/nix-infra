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
          # TODO: set HF_TOKEN_PATH instead in a wrapped hf-hub drv
          #TODO: should be a system concern, not deployed to a specific user?
        };
      });
    homeModules.huggingface = {pkgs, ...}: {
      home.packages = [pkgs.python3Packages.huggingface-hub];
    };
  };
  deployments.homeModules.huggingface = ["kerry-scruncher"];
}
