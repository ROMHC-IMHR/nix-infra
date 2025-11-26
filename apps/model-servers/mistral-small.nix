{inputs, ...}: {
  perSystem = {system, ...}: let
    pkgs = import inputs.nixpkgs {
      system = system;
      config.allowUnfree = true;
      config.cudaSupport = true;
    };
    pythonRuntime = pkgs.python3.withPackages (ps:
      with ps; [
        diskcache
        fastapi
        huggingface-hub
        llama-cpp-python
        numpy
        psutil
        pydantic-settings
        sse-starlette
        starlette-context
        uvicorn
      ]);
    modelPath = "/HDD_12TB/kerry/models/gguf/bartowski";
  in {
    apps.mistral-small = {
      type = "app";
      program = pkgs.writeShellApplication {
        name = "llama-cpp-python-no-model";
        runtimeInputs = [pythonRuntime];
        runtimeEnv = {
          LD_PRELOAD = "/usr/lib/x86_64-linux-gnu/libcuda.so.1";
        };
        text = ''
          exec ${pkgs.lib.getExe pythonRuntime} -m llama_cpp.server \
                    --model ${modelPath}/Mistral-Small-3.1-34B-Instruct-2503-Q4_K_M/mistralai_Mistral-Small-3.1-24B-Instruct-2503-Q4_K_M.gguf \
                    --model_alias mistral-small \
                    --host 0.0.0.0 --port 8080 \
                    --n_gpu_layers -1 \
                    --main_gpu 0 \
                    --split_mode 0 \
                    --chat_format chatml-function-calling
        '';
      };
    };
  };
}
