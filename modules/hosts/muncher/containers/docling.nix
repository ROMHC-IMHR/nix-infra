{inputs, ...}: {
  flake.nixosModules.muncher = {
    pkgs,
    config,
    lib,
    ...
  }: let
    graniteModel = pkgs.fetchgit {
      url = "https://huggingface.co/ibm-granite/granite-docling-258M";
      rev = "982fe3b40f2fa73c365bdb1bcacf6c81b7184bfe";
      fetchLFS = true;
      hash = "sha256-wQpktGnq2yHt6jqK5HqN/ilVdjbUAB5ZVEB2qlEIhJI=";
    };
  in {
    hardware.nvidia-container-toolkit.enable = true;
    virtualisation.oci-containers.containers.docling = {
      image = "ghcr.io/docling-project/docling-serve-cu128:v1.13.1";
      environment = {
        DOCLING_SERVE_ENABLE_UI = "true";
        DOCLING_SERVE_ENABLE_REMOTE_SERVICES = "true";
        DOCLING_SERVE_MAX_DOCUMENT_TIMEOUT = "300";
        DOCLING_DEVICE = "cuda:0";
        RAPIDOCR_ORT_PROVIDERS = "CUDAExecutionProvider,CPUExecutionProvider";
        ORT_DISABLE_AZURE = "1";
      };
      ports = ["5001:5001"];
      extraOptions = [
        "--device=nvidia.com/gpu=0"
      ];
      volumes = [
        "${graniteModel}:/opt/app-root/src/.cache/docling/models/ibm-granite--granite-docling-258M:ro"
      ];
    };
  };
}
