{
  flake.nixosModules.muncher = {
    networking = {
      hostName = "muncher";
      useDHCP = false;
      interfaces = {
        eno8303 = {
          ipv4.addresses = [
            {
              address = "10.156.156.172";
              prefixLength = 24;
            }
          ];
        };
        eno8403 = {
          useDHCP = false;
        };
      };
      defaultGateway = "10.156.156.1";
      nameservers = ["10.156.156.10" "10.156.156.11"];
      search = ["bic.theroyal.ca"];
    };
  };
}
