{
  perSystem = {
    lib,
    pkgs,
    ...
  }: {
    packages.qwen3_8-27b-fp8 = pkgs.fetchFromHuggingFace {
      name = "qwen3.8-27b-fp8";
      repoId = "Qwen/Qwen3.8-27B-FP8";
      rev = "017b9c7af6b5689d5dd426a76e0bc077eb5ca20a";
      backend = "lfs";
      hash = lib.fakeHash; # replace with the hash prefetch-model.sh prints
    };
  };
}
