{inputs, ...}: {
  perSystem = {
    system,
    lib,
    ...
  }: let
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
    packages.llama-cpp-python = pkgs.writeShellApplication {
      name = "llama-cpp-python";
      runtimeInputs = [pythonRuntime];
      runtimeEnv = {
        HF_HOME = "/HDD_12TB/kerry/huggingface";
        LD_PRELOAD = "/usr/lib/x86_64-linux-gnu/libcuda.so.1";
      };
      text = ''
        exec ${pkgs.lib.getExe pythonRuntime} -m llama_cpp.server "$@"
      '';
    };
  };
}
