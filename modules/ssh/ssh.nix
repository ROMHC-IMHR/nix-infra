{self, ...}: {
  flake = {
    nixosModules = {
      ssh = {...}: {
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
      muncher.imports = [self.nixosModules.ssh];
    };
    homeModules = {
      ssh.programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        includes = ["~/.ssh/config.d/*.conf"];
        settings = {
          "*" = {
            controlMaster = "auto";
            controlPersist = "10m";
            identitiesOnly = true;
            serverAliveInterval = 15;
            serverAliveCountMax = 3;
            controlPath = "~/.ssh/master-%r@%n:%p";
            addKeysToAgent = "yes";
          };
          "github" = {
            hostname = "github.com";
            user = "git";
          };
        };
      };
      muncher.imports = [self.homeModules.ssh];
    };
  };
}
