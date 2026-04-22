{...}: {
  perSystem = {inputs', pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      packages = [
        (inputs'.kc-nix-infra.packages.neovim.wrap {
          aspects.lang.nix.enable = true;
        })
      ];
    };
  };
}
