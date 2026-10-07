{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.installer = {
    modulesPath,
    pkgs,
    ...
  }: let
    neovim = inputs.kc-nix-infra.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
  in {
    imports = ["${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"];
    environment.systemPackages = [
      inputs.disko.packages.${pkgs.stdenv.hostPlatform.system}.disko
      pkgs.git
      (neovim.wrap {
        aspects.lang.nix.enable = true;
      })
    ];
  };
  deployments.nixosModules.installer = [
    "scruncher-installer"
  ];
}
