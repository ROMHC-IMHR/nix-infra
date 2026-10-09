{
  self,
  inputs,
  ...
}: let
  stateVersion = "26.11";
in {
  flake = {
    nixosModules.scruncher = {
      system.stateVersion = stateVersion;
      sops = {
        defaultSopsFile = ./secrets.yaml;
        defaultSopsFormat = "yaml";
      };
    };
    nixosConfigurations.scruncher = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.scruncher];
    };
    homeModules.scruncher.home.stateVersion = stateVersion;
  };
  deployments.homeModules.scruncher = ["kerry-scruncher"];
}
