{inputs, ...}: {
  perSystem = {
    system,
    lib,
    ...
  }: let
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    packages.openwebui = pkgs.writeShellApplication {
      name = "openwebui-server";
      runtimeEnv = {
        ANONYMIZED_TELEMETRY = "False";
        DO_NOT_TRACK = "True";
        SCARF_NO_ANALYTICS = "True";
        WEBUI_AUTH = "False";
      };
      text = ''
        : "''${XDG_DATA_HOME:="$HOME/.local/share"}"
        : "''${DATA_DIR:="$XDG_DATA_HOME/open-webui"}"
        mkdir -p "''${DATA_DIR}"
        export DATA_DIR

        exec ${lib.getExe pkgs.open-webui} serve \
        --host 0.0.0.0 --port 8082 "$@"
      '';
    };
  };
}
