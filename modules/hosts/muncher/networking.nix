{
  flake.nixosModules.muncher = {
    # 1. Disable DHCP for this interface (replace 'enp3s0' with your actual interface name!)
    # networking.interfaces.enp3s0.useDHCP = false;

    # 2. Hardcode the IP and Subnet
    # networking.interfaces.enp3s0.ipv4.addresses = [ {
    #   address = "192.168.1.50"; # The IP you want
    #   prefixLength = 24;        # This means subnet mask 255.255.255.0
    # } ];

    # 3. Hardcode the Router's IP (Gateway)
    # networking.defaultGateway = "192.168.1.1";

    # 4. Hardcode DNS (Since the router isn't telling us anymore)
    # networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };
}
