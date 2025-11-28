{inputs, ...}: {
  perSystem = {system, ...}: let
    pkgs = import inputs.nixpkgs {
      system = system;
      config.allowUnfree = true;
      config.cudaSupport = true;
    };
    runtimeEnv = {
      OLLAMA_HOST = "0.0.0.0:11434";
      OLLAMA_MODELS = "/HDD_12TB/kerry/ollama/";
      OLLAMA_KEEP_ALIVE = "5m";
      LD_PRELOAD = "/usr/lib/x86_64-linux-gnu/libcuda.so.1";
    };
  in {
    packages.ollama = pkgs.writeShellApplication {
      inherit runtimeEnv;
      name = "ollama-server";
      runtimeInputs = [pkgs.ollama];
      text = ''
        # Ensure model directory exists
        mkdir -p ${runtimeEnv.OLLAMA_MODELS}
        exec ${pkgs.ollama}/bin/ollama serve
      '';
    };
    devShells.default = pkgs.mkShell ({
        shellHook = ''
          echo "Environment configured. You can now run 'ollama pull' or 'ollama run' using the local ./ollama-models directory."
        '';
        packages = [pkgs.ollama];
      }
      // runtimeEnv);
  };
}
