{
  perSystem =
    { lib, pkgs, ... }:
    {
      packages.qwen3_8-flash-next-w4a16 = pkgs.fetchFromHuggingFace {
        name = "qwen3.8-flash-next-w4a16-autoround";
        repoId = "Intel/Qwen3.8-Flash-Next-W4A16-AutoRound";
        rev = "4c67bf686b7f7fd386bae6b07ab59e8ff1d5b897";
        backend = "lfs";
        hash = "sha256-0dI5NlahNV+drj5LNbQirvKucSiTymSWltlBw7o0kSI=";
      };
    };
}
