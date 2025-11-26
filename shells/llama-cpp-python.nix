{inputs, ...}: {
  perSystem = {system, ...}: let
    pkgs = import inputs.nixpkgs {
      system = system;
      config.allowUnfree = true;
      config.cudaSupport = true;
    };
  in {
    devShells.llama-cpp-python = pkgs.mkShell {
      buildInputs = with pkgs; [
        (python3.withPackages (ps:
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
          ]))
      ];
      LD_PRELOAD = "/usr/lib/x86_64-linux-gnu/libcuda.so.1";
    };
  };
}
