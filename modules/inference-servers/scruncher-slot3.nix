{moduleWithSystem, ...}: {
  flake.nixosModules.vllm-bigboy = moduleWithSystem (
    {self'}: {...}: let
      model = self'.packages.qwen3_8-flash-next-w4a16.outPath;
      port = 18002;
    in {
      hardware.nvidia-container-toolkit.enable = true;

      virtualisation.oci-containers = {
        backend = "podman";
        containers.vllm-bigboy = {
          # vllm/vllm-openai:v0.32.0 (multi-arch index; CUDA 13.0, needs driver >= 580)
          image = "docker.io/vllm/vllm-openai@sha256:befccf0e7e4089aa23926bb6f887a85c0d46c2a99e6de5c5ffdf5cb7957c5b34";
          cmd = [
            model
            "--served-model-name"
            "qwen3.8-flash-next"
            "--host"
            "127.0.0.1"
            "--port"
            (toString port)
            # PLE (the n-gram table) rejects PP > 1, so split by tensor parallel.
            # EP is required: experts are 640 wide, 320 per GPU under plain TP,
            # which is not a multiple of the 128-wide quant groups Marlin needs.
            "--tensor-parallel-size"
            "2"
            "--enable-expert-parallel"
            "--gpu-memory-utilization"
            "0.90"
            "--max-model-len"
            "262144"
            "--max-num-seqs"
            "8"
            "--kv-cache-dtype"
            "fp8"
            "--attention-config"
            (builtins.toJSON {indexer_kv_dtype = "fp8";})
            # Images and video at the model's own limits (16 MP images, up to
            # 16,384 tokens each). vLLM reserves memory for one largest item, so
            # per-prompt counts cost nothing at startup. If 262144 then fails to
            # fit, cap images first with --mm-processor-kwargs '{"max_pixels": ...}'.
            "--reasoning-parser"
            "qwen3"
            "--enable-auto-tool-choice"
            "--tool-call-parser"
            "qwen3_coder"
          ];
          devices = [
            "nvidia.com/gpu=2"
            "nvidia.com/gpu=3"
          ];
          volumes = [
            "${model}:${model}:ro"
            "/var/cache/vllm-bigboy:/root/.cache"
          ];
          environment = {
            HF_HUB_OFFLINE = "1";
            TRITON_CACHE_DIR = "/root/.cache/triton";
            VLLM_NO_USAGE_STATS = "1";
            # The API server gives the engine 600 s by default; loading 181 GB,
            # pinning the 95 GiB n-gram table and compiling takes longer.
            VLLM_ENGINE_READY_TIMEOUT_S = "3600";
          };
          extraOptions = [
            "--network=host"
            "--ipc=host"
            "--health-cmd=curl -fsS http://127.0.0.1:${toString port}/health"
            "--health-interval=10s"
            "--health-start-period=60m"
            "--cpuset-cpus=32-63,96-127"
          ];
          podman.sdnotify = "healthy";
        };
      };

      systemd.services.podman-vllm-bigboy = {
        requires = ["nvidia-container-toolkit-cdi-generator.service"];
        after = ["nvidia-container-toolkit-cdi-generator.service"];
        serviceConfig.CacheDirectory = "vllm-bigboy";
      };
    }
  );
  deployments.nixosModules.vllm-bigboy = ["scruncher"];
}
