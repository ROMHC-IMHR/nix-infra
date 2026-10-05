{self, ...}: {
  flake.nixosModules = {
    nix = {pkgs, ...}: {
      nix = {
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
            "pipe-operators"
          ];
          auto-optimise-store = true;
          trusted-users = ["root" "@wheel"];
          max-jobs = "auto";
          cores = 0;
        };
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 30d";
        };
      };
    };
  };
  deployments.nixosModules.nix = [
    "muncher"
    "scruncher"
  ];
}
