{lib, ...}: {
  flake.lib.constants.knownHostPKs =
    lib.genAttrs [
      "scruncher"
      "muncher"
    ] (host:
      lib.trim (
        builtins.readFile (
          ./public-keys + "/${host}/root_ed25519.pub"
        )
      ));
}
