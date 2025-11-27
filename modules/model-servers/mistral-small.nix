{inputs, ...}: {
  perSystem = {self', lib, system, ...}: let
    pkgs = import inputs.nixpkgs {
      system = system;
      config.allowUnfree = true;
      config.cudaSupport = true;
    };
    modelArgs = [
      "--model" "/HDD_12TB/kerry/models/gguf/bartowski/Mistral-Small-3.1-34B-Instruct-2503-Q4_K_M/mistralai_Mistral-Small-3.1-24B-Instruct-2503-Q4_K_M.gguf"
      "--model_alias" "mistral-small"
      "--host" "0.0.0.0"
      "--port" "8081"
      "--n_gpu_layers" "-1"
      "--main_gpu" "0"
      "--split_mode" "0"
      "--chat_format" "chatml-function-calling"
    ];
  in {
    apps.mistral-small = {
      type = "app";
      program = pkgs.writeShellApplication {
        name = "mistral-small-server";
        runtimeInputs = [ self'.packages.llama-cpp-python ];
        runtimeEnv = {
          LD_PRELOAD = "/usr/lib/x86_64-linux-gnu/libcuda.so.1";
        };
        text = ''
          exec ${pkgs.lib.getExe self'.packages.llama-cpp-python} \
            ${lib.escapeShellArgs modelArgs} \
            "$@"
        '';
      };
    };
  };
}
