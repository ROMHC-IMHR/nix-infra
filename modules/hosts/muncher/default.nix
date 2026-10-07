{
  self,
  inputs,
  ...
}: let
  stateVersion = "25.11";
in {
  flake = {
    nixosModules.muncher = {
      system.stateVersion = stateVersion;
      imports = [inputs.home-manager.nixosModules.home-manager];
    };
    nixosConfigurations.muncher = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = with self.nixosModules; [
        muncher
      ];
    };
    homeModules = {
      muncher.home.stateVersion = stateVersion;
      kerry-muncher.imports = [self.homeModules.muncher];
    };
  };
}
