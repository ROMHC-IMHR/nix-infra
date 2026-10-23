{lib, ...}: {
  flake.lib.constants = {
    knownHostPKs = let
      readKeys = keyPath: lib.trim (builtins.readFile keyPath);
    in
      lib.genAttrs [
        "scruncher"
        "muncher"
      ] (host: readKeys (./public-keys + "/${host}/root_ed25519.pub"));
    userAuthPKs = let
      readKeys = keyPath: lib.splitString "\n" (builtins.readFile keyPath);
    in
      lib.genAttrs [
        "kerry"
        "abarton"
        "chonderich"
        "fdjimbouon"
        "kkeskin"
        "ktabay"
        "ltuominen"
        "mzhang"
        "oclarkin"
        "ycatal"
        "zkaminsky"
      ] (user: readKeys (./auth-keys + "/${user}"));
  };
}
