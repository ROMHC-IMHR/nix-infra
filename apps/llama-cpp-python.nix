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
  in {
    apps.llama-cpp-python = {
      type = "app";
      program = pkgs.writeShellApplication {
        name = "llama-cpp-python-no-model";
        runtimeInputs = [pythonRuntime];
        runtimeEnv = {
          LD_PRELOAD = "/usr/lib/x86_64-linux-gnu/libcuda.so.1";
        };
        text = ''
          exec ${pkgs.lib.getExe pythonRuntime} -m llama_cpp.server "$@"
        '';
      };
    };
  };
}
