{
  perSystem =
    { pkgs, ... }:
    {
      # Prefetch a Hugging Face repo for fetchFromHuggingFace: download it with the
      # resumable `hf` CLI, add it to the store at the path the fetcher expects, and
      # print the fetcher expression.
      #
      # usage: prefetch-model REPO_ID REV [FILE...]
      #
      # Runs as your user, so `hf` sees your token. The download directory
      # ./<name> is kept: a rerun resumes, and a new revision reuses unchanged files.
      # `nix` comes from the host so it matches the running daemon.
      packages.prefetch-huggingface = pkgs.writeShellApplication {
        name = "prefetch-model";
        runtimeInputs = [
          pkgs.jq
          pkgs.python3Packages.huggingface-hub
        ];
        text = ''
          if [[ $# -lt 2 ]]; then
            echo "usage: prefetch-model REPO_ID REV [FILE...]" >&2
            exit 2
          fi
          repo=$1
          rev=$2
          shift 2
          files=("$@")
          name=''${repo#*/}

          dir=$PWD/$name
          hf download "$repo" "''${files[@]}" --revision "$rev" --local-dir "$dir" >&2
          # hf writes its own metadata here; it is not part of the fetcher's output.
          rm -rf "$dir/.cache"

          path=$(nix --extra-experimental-features nix-command \
            store add --mode nar --hash-algo sha256 --name "$name" "$dir")
          echo "added $path" >&2

          # Read the hash Nix recorded while adding, instead of hashing again.
          hash=$(nix --extra-experimental-features nix-command \
            hash convert --to sri "$(nix-store --query --hash "$path")")

          echo "fetchFromHuggingFace {"
          echo "  name = $(jq -n --arg v "$name" '$v');"
          echo "  repoId = $(jq -n --arg v "$repo" '$v');"
          echo "  rev = $(jq -n --arg v "$rev" '$v');"
          echo "  backend = \"lfs\";"
          if [[ ''${#files[@]} -gt 0 ]]; then
            # Root-level files need non-cone mode; cone mode always includes them.
            echo "  nonConeMode = true;"
            echo "  sparseCheckout = ["
            for f in "''${files[@]}"; do
              echo "    $(jq -n --arg v "/$f" '$v')"
            done
            echo "  ];"
          fi
          echo "  hash = \"$hash\";"
          echo "}"
        '';
      };
    };
}
