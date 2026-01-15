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
    users.users.kerry.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtCFAEnUE/6pRWjylYWqAgsfswF0GTlK04ZKMjWNiZn kerry@claudius"
    ];
  };
}
