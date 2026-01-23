{
  flake.nixosModules.muncher = {...}: {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "prohibit-password";
        UseDns = false;
        StrictModes = true;
      };
    };
  };
}
