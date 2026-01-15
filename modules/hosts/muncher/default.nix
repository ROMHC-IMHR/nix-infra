{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.muncher = {
    system.stateVersion = "25.11";
    imports = with self.nixosModules; [
      inputs.sops-nix.nixosModules.sops
      inputs.home-manager.nixosModules.home-manager
    ];
  };
  flake.nixosConfigurations.muncher = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = with self.nixosModules; [
      muncher
    ];
  };
}
