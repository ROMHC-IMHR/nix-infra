{
  flake.nixosModules.muncher = {pkgs, ...}: {
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
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        zlib
        glib
        glibc
        openssl
        libxml2
        libz
        libGL
        libxkbcommon
        fontconfig
        freetype
        xorg.libX11
        xorg.libXext
        xorg.libXrender
        xorg.libICE
        xorg.libSM
        gfortran.cc.lib
        curl
        linuxPackages.nvidia_x11
        cudaPackages.cudatoolkit
        cudaPackages.cudnn
      ];
    };
  };
}
