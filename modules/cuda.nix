{self, ...}: {
  flake.nixosModules.cuda = {pkgs, ...}: {
    nixpkgs.config = {
      allowUnfree = true;
      cudaSupport = true;
    };
    nix.settings = {
      substituters = ["https://cache.nixos-cuda.org"];
      trusted-public-keys = ["cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="];
    };
    programs.nix-ld.libraries = with pkgs; [
      linuxPackages.nvidia_x11
      cudaPackages.cudatoolkit
      cudaPackages.cudnn
    ];
  };
  flake.nixosModules.muncher.imports = [self.nixosModules.cuda];
}
