{
  self,
  inputs,
  lib,
  ...
}: {
  flake.nixosModules.cruncher = {
    imports = with self.nixosModules; [
      inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
    ];
  };
  flake.nixosConfigurations.cruncher = lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self.nixosModules; [
      cruncher
    ];
  };
}
