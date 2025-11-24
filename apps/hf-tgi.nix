{lib, ...}: {
  perSystem = {
    inputs',
    pkgs,
    ...
  }: {
    apps.hf-tgi = {
      type = "app";
      program = pkgs.writeShellApplication {
        name = "tgi-server";
        text = ''
          export HF_HOME=/HDD_12TB/kerry/huggingface
          export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libcuda.so.1"
          exec ${lib.getExe inputs'.tgi-flake.packages.default} "$@"
        '';
      };
    };
  };
}
