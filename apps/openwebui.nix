{inputs, ...}: {
  perSystem = {system, ...}: let
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    apps.openwebui = {
      type = "app";
      program = pkgs.writeShellApplication {
        name = "openwebui-server";
        text = ''
          set -euo pipefail

          # Pick a writable state dir (XDG if present, else ~/.local/share/open-webui)
          : ''${XDG_DATA_HOME:="$HOME/.local/share"}
          : ''${DATA_DIR:="$XDG_DATA_HOME/open-webui"}
          mkdir -p "''${DATA_DIR}"
          export DATA_DIR

          # Optional: if you plan to use Functions that pip-install packages,
          # direct pip to user site-packages to avoid the Nix store.
          : ''${PIP_OPTIONS:="--user"}
          export PIP_OPTIONS

          # Telemetry off
          export ANONYMIZED_TELEMETRY=False
          export DO_NOT_TRACK=True
          export SCARF_NO_ANALYTICS=True

          # Disable built-in auth
          export WEBUI_AUTH=False

          # Backend defaults you can override at runtime
          : ''${OLLAMA_API_BASE_URL:=http://127.0.0.1:8080/v1}
          : ''${PORT:=8082}

          exec ${pkgs.open-webui}/bin/open-webui serve \
          --host 0.0.0.0 --port "''${PORT}" "$@"
        '';
      };
    };
  };
}
