{
  flake.nixosModules.muncher = {
    config,
    lib,
    pkgs,
    ...
  }: let
    ollamaDataDir = "/mnt/ssdstore/ollama";
  in {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;
      host = "127.0.0.1";
      port = 11434;
      home = ollamaDataDir;
      user = "ollama";
      group = "ollama";
    };
    systemd = {
      tmpfiles.rules = [
        "d ${ollamaDataDir} 0755 ollama ollama -"
      ];
    };
  };
}
