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
      sops = {
        defaultSopsFile = ./secrets.yaml;
        defaultSopsFormat = "yaml";
      };
    };
    nixosConfigurations.muncher = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.muncher];
    };
    homeModules = {
      muncher.home.stateVersion = stateVersion;
      kerry-muncher.imports = [self.homeModules.muncher];
    };
  };
}
