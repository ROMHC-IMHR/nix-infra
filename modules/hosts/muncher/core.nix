{
  flake.nixosModules.muncher-core = {
    i18n.defaultLocale = "en_CA.UTF-8";
    services.xserver = {
      xkb.layout = "us";
      xkb.variant = "";
    };
  };
  deployments.nixosModules.muncher-core = [
    "muncher"
    "muncher-installer"
  ];
}
