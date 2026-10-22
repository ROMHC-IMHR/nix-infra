{self, ...}: let
  ports = map toString [18001 18002];
  muncherPK = self.lib.constants.knownHostPKs.muncher;
in {
  flake.nixosModules = {
    scruncher = {lib, ...}: {
      users.groups.vllm-tunnel = {};
      users.users.vllm-tunnel = {
        isSystemUser = true;
        group = "vllm-tunnel";
        openssh.authorizedKeys.keys = let
          permitopens =
            lib.concatMapStringsSep
            "," (p: ''permitopen="127.0.0.1:${p}"'')
            ports;
        in [
          "restrict,port-forwarding,${permitopens} ${muncherPK}"
        ];
      };
    };
    muncher = {lib, ...}: {
      services.autossh-ng.sessions.vllm = {
        user = "root";
        destination = "vllm-tunnel@scruncher";
        hostKeyChecking = true;
        knownHostsFile = "/etc/ssh/ssh_known_hosts";
        extraArguments = lib.mkMerge (
          [
            "-i /etc/ssh/ssh_host_ed25519_key"
            "-o IdentitiesOnly=yes"
          ]
          ++ map (p: "-L 127.0.0.1:${p}:127.0.0.1:${p}") ports
        );
      };
    };
  };
}
