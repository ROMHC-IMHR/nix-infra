{
  inputs,
  self,
  ...
}: {
  flake = {
    nixosModules.scruncher-installer.isoImage.storeContents = [
      self.nixosConfigurations.scruncher.config.system.build.toplevel
    ];
    nixosConfigurations.scruncher-installer = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [self.nixosModules.scruncher-installer];
    };
  };
}
