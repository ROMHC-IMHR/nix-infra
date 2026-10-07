{
  flake.nixosModules.scruncher-core = {
    config,
    lib,
    ...
  }: {
    i18n.defaultLocale = "en_CA.UTF-8";
    networking.hostName = "scruncher";
    services.xserver = {
      xkb.layout = "us";
      xkb.variant = "";
    };
    nixpkgs.config.allowUnfree = true;
  };
  deployments.nixosModules.scruncher-core = [
    "scruncher"
    "scruncher-installer"
  ];
}
