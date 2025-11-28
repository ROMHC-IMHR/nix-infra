{inputs, ...}: {
  perSystem = {
    system,
    inputs',
    lib,
    ...
  }: let
    pkgs = import inputs.nixpkgs {
      system = system;
      config.allowUnfree = true;
      config.cudaSupport = true;
    };
  in {
    packages.hf-tgi = pkgs.writeShellApplication {
      name = "tgi-server";
      runtimeEnv = {
        HF_HOME = "/HDD_12TB/kerry/huggingface";
        LD_PRELOAD = "/usr/lib/x86_64-linux-gnu/libcuda.so.1";
      };
      text = ''
        exec ${lib.getExe inputs'.tgi-flake.packages.default} "$@"
      '';
    };
  };
}
