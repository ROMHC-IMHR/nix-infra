{
  flake.nixosModules.muncher = {
    services.openssh.settings.DenyUsers = ["ktabay"];
  };
}
