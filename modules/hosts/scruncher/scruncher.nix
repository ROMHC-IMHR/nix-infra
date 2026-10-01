{
  self,
  inputs,
  ...
}: let
  stateVersion = "26.11";
in {
  flake = {
    nixosModules.scruncher.system.stateVersion = stateVersion;
    nixosConfigurations.scruncher= inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.scruncher];
    };
    homeModules = {
      scruncher.home.stateVersion = stateVersion;
      kerry-scruncher.imports = [self.homeModules.claudius];
    };
  };
}
