{
  flake.nixosModules.scruncher = {
    networking = {
      useDHCP = false;
      interfaces = {
        ens22f0 = {
          ipv4.addresses = [
            {
              address = "10.156.156.140";
              prefixLength = 24;
            }
          ];
        };
      };
      defaultGateway = "10.156.156.1";
      nameservers = ["10.156.156.10" "10.156.156.11"];
      search = ["bic.theroyal.ca"];
    };
  };
}
