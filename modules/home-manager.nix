{inputs, ...}: {
  flake.nixosModules = {
    home-manager = {lib, ...}: {
      imports = [inputs.home-manager.nixosModules.home-manager];
      home-manager = {
        useGlobalPkgs = lib.mkDefault true;
        useUserPackages = lib.mkDefault true;
        backupFileExtension = lib.mkDefault "bak";
      };
    };
  };
  deployments.nixosModules.home-manager = [
    "muncher"
    "scruncher"
  ];
}
