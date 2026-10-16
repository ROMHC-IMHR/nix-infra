{moduleWithSystem, ...}: {
  flake.nixosModules.vllm-workhorse = moduleWithSystem (
    {self'}: {...}: let
      model = builtins.unsafeDiscardStringContext self'.packages.qwen3_8-27b-fp8.outPath;
      port = 18001;
    in {
      hardware.nvidia-container-toolkit.enable = true;
      virtualisation.oci-containers = {
        backend = "podman";
        containers.vllm-workhorse = {
          image = "docker.io/vllm/vllm-openai@sha256:c2914767605584b6d8f45686b82de173ecc99e781897aa3d0a66dacd72c51ae1";
          cmd = [
            model
            "--served-model-name"
            "qwen3.8-27b"
            "--host"
            "127.0.0.1"
            "--port"
            (toString port)
            "--gpu-memory-utilization"
            "0.90"
            "--max-model-len"
            "131072"
            "--kv-cache-dtype"
            "fp8"
            "--max-num-seqs"
            "16"
            "--reasoning-parser"
            "qwen3"
            "--enable-auto-tool-choice"
            "--tool-call-parser"
            "qwen3_coder"
            "--speculative-config"
            (builtins.toJSON {
              method = "mtp";
              num_speculative_tokens = 3;
            })
          ];
          devices = ["nvidia.com/gpu=0"];
          volumes = [
            "${model}:${model}:ro"
            "/var/cache/vllm-workhorse:/root/.cache"
          ];
          environment = {
            HF_HUB_OFFLINE = "1";
            TRITON_CACHE_DIR = "/root/.cache/triton";
            VLLM_NO_USAGE_STATS = "1";
          };
          extraOptions = [
            "--network=host"
            "--ipc=host"
            "--health-cmd=curl -fsS http://127.0.0.1:${toString port}/health"
            "--health-interval=10s"
            "--health-start-period=30m"
          ];
          podman.sdnotify = "healthy";
        };
      };
      systemd.services.podman-vllm-workhorse = {
        requires = ["nvidia-container-toolkit-cdi-generator.service"];
        after = ["nvidia-container-toolkit-cdi-generator.service"];
        serviceConfig.CacheDirectory = "vllm-workhorse";
      };
    }
  );
  deployments.nixosModules.vllm-workhorse = ["scruncher"];
}
