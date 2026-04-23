{
  self,
  inputs,
  ...
}: let
  mcpoDataDir = "/mnt/ssdstore/mcpo";
  mcpoUid = 996;
  mcpoGid = 996;
  mcpoUser = {
    isSystemUser = true;
    group = "mcpo";
    description = "MCPO Service User";
    uid = mcpoUid;
  };
  mcpoGroup = {gid = mcpoGid;};
in {
  flake.nixosModules.muncher = {
    containers.mcpo = {
      autoStart = true;
      privateNetwork = false;
      bindMounts = {
        "/var/lib/mcpo" = {
          hostPath = mcpoDataDir;
          isReadOnly = false;
        };
        # "/etc/ssh/ssh_host_ed25519_key" = {
        #   hostPath = "/etc/ssh/ssh_host_ed25519_key";
        #   isReadOnly = true;
        # };
      };
      nixpkgs = inputs.owui-nixpkgs;
      config = {
        config,
        pkgs,
        lib,
        ...
      }: {
        imports = [inputs.sops-nix.nixosModules.sops];
        nixpkgs = {
          overlays = self.mcp.pythonOverrides;
          config = {
            allowUnfree = true;
          };
        };
        environment.etc."mcpo/config.json".text = builtins.toJSON {
          mcpServers = {
            arxiv = {
              command = lib.getExe inputs.kc-nix-infra.packages.${pkgs.system}.arxiv-mcp-server;
              args = ["--storage-path" "/var/lib/mcpo/arxiv"];
            };
            nixos = {
              command = lib.getExe pkgs.mcp-nixos;
              args = [];
            };
            biomcp = {
              command = lib.getExe self.packages.${pkgs.system}.biomcp;
              args = ["serve"];
            };
          };
        };
        # sops = {
        #   defaultSopsFile = ./secrets.yaml;
        #   age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
        #   templates.mcpoConfig = {
        #     content = builtins.toJSON {
        #       mcpServers = {
        #         arxiv = {
        #           command = lib.getExe self.packages.${pkgs.system}.arxiv-mcp-server;
        #           args = ["--storage-path" "/var/lib/mcpo/arxiv"];
        #         };
        #         nixos = {
        #           command = lib.getExe pkgs.mcp-nixos;
        #           args = [];
        #         };
        #       };
        #     };
        #     path = "/etc/mcpo/config.json";
        #   };
        # };
        system.stateVersion = "25.11";
        systemd.services.mcpo = {
          description = "MCP-to-OpenAPI proxy for Open WebUI";
          after = ["network.target"];
          wantedBy = ["multi-user.target"];
          serviceConfig = {
            User = "mcpo";
            ReadWritePaths = ["/var/lib/mcpo"];
            ExecStart = ''
              ${lib.getExe self.packages.${pkgs.system}.mcpo} \
                --port 8000 \
                --config /etc/mcpo/config.json
            '';
            Restart = "always";
          };
        };
        users = {
          users.mcpo = mcpoUser;
          groups.mcpo = mcpoGroup;
        };
      };
    };
    systemd.tmpfiles.rules = ["d ${mcpoDataDir} 0700 mcpo mcpo -"];
    users = {
      users.mcpo = mcpoUser;
      groups.mcpo = mcpoGroup;
    };
  };
}
