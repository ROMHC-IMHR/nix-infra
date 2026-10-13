{
  flake.nixosModules.muncher-core = {
    config,
    lib,
    ...
  }: {
    i18n.defaultLocale = "en_CA.UTF-8";
    networking.hostName = "muncher";
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
