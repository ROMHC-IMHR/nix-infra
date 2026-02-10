{
  flake.nixosModules.muncher = let
    owuiStateDir = "/mnt/ssdstore/open-webui";
  in
    {
      config,
      lib,
      ...
    }: {
      networking.firewall.allowedTCPPorts = [ 8080 ];
      sops.secrets = {
        "openwebui/environment" = {
          owner = "root";
          group = "root";
          mode = "0400";
          restartUnits = ["open-webui.service"];
        };
      };
      services.open-webui = {
        enable = true;
        port = 8080;
        host = "0.0.0.0";
        stateDir = owuiStateDir;
        environment = {
          ANONYMIZED_TELEMETRY = "False";
          DO_NOT_TRACK = "True";
          SCARF_NO_ANALYTICS = "True";
          OLLAMA_API_BASE_URL = "http://127.0.0.1:${
            toString config.services.ollama.port
          }";
          ENABLE_SIGNUP = "True";
          DEFAULT_USER_ROLE = "pending";
          USE_CUDA = "True";
        };
        environmentFile = config.sops.secrets."openwebui/environment".path;
      };
      users = {
        users.open-webui = {
          isSystemUser = true;
          group = "open-webui";
          description = "Open WebUI Service User";
        };
        groups.open-webui = {};
      };
      systemd = {
        services.open-webui.serviceConfig = {
          DynamicUser = lib.mkForce false;
          User = "open-webui";
          ReadWritePaths = [owuiStateDir];
        };
        tmpfiles.rules = [
          "d ${owuiStateDir} 0700 open-webui open-webui -"
        ];
      };
    };
}
