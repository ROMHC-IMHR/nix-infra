{inputs, ...}: {
  flake.nixosModules.muncher = let
    owuiStateDir = "/mnt/ssdstore/open-webui";
    owuiUid = 995;
    owuiGid = 993;
    owuiUser = {
      isSystemUser = true;
      group = "open-webui";
      description = "Open WebUI Service User";
      uid = owuiUid;
    };
    owuiGroup = {
      gid = owuiGid;
    };
  in
    {
      config,
      lib,
      ...
    }: {
      containers.open-webui = {
        autoStart = true;
        privateNetwork = false;
        bindMounts = {
          "/var/lib/open-webui" = {
            hostPath = owuiStateDir;
            isReadOnly = false;
          };
          "/run/secrets/openwebui/environment" = {
            hostPath = config.sops.secrets."openwebui/environment".path;
            isReadOnly = true;
          };
        };
        nixpkgs = inputs.owui-nixpkgs;
        config = {pkgs, ...}: {
          nixpkgs.config = {
            allowUnfree = true;
            cudaSupport = true;
          };
          services.open-webui = {
            enable = true;
            port = 8080;
            host = "0.0.0.0";
            environment = {
              ENABLE_VERSION_UPDATE_CHECK = "False";
              ANONYMIZED_TELEMETRY = "False";
              DO_NOT_TRACK = "True";
              SCARF_NO_ANALYTICS = "True";
              OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
              ENABLE_SIGNUP = "True";
              DEFAULT_USER_ROLE = "pending";
              USE_CUDA = "True";
            };
            environmentFile = "/run/secrets/openwebui/environment";
          };
          system.stateVersion = "26.05";
          users = {
            users.open-webui = owuiUser;
            groups.open-webui = owuiGroup;
          };
          systemd = {
            services.open-webui.serviceConfig = {
              DynamicUser = lib.mkForce false;
              User = "open-webui";
              ReadWritePaths = ["/var/lib/open-webui"];
            };
          };
        };
      };
      networking.firewall.allowedTCPPorts = [8080];
      sops.secrets = {
        "openwebui/environment" = {
          owner = "open-webui";
          group = "open-webui";
          mode = "0400";
          restartUnits = ["container@open-webui.service"];
        };
      };
      systemd.tmpfiles.rules = [
        "d ${owuiStateDir} 0700 open-webui open-webui -"
      ];
      users = {
        users.open-webui = owuiUser;
        groups.open-webui = owuiGroup;
      };
    };
}
