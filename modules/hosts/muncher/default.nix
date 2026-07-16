{
  self,
  inputs,
  ...
}: {
  flake = {
    nixosModules.muncher = {
      system.stateVersion = "25.11";
      imports = [inputs.home-manager.nixosModules.home-manager];
    };
    nixosConfigurations.muncher = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.nixosModules; [
        muncher
      ];
    };
    homeModules = {
      muncher.home.stateVersion = "25.11";
      "kerry@muncher".imports = [self.homeModules.muncher];
    };
  };
}
