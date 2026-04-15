{...}: {
  perSystem = {inputs', pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      packages = [
        (inputs'.packages.neovim.wrap {
          aspects.lang.nix.enable = true;
        })
      ];
    };
  };
}
