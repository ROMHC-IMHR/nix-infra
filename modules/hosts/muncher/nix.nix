{
  flake.nixosModules.muncher = {
    nixpkgs.config = {
      allowUnfree = true;
      cudaSupport = true;
    };
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
        substituters = ["https://cache.nixos-cuda.org"];
        trusted-public-keys = ["cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="];
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
    };
  };
}
