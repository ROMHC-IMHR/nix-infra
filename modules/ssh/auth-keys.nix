{lib, ...}: {
  flake.nixosModules.ssh.users.users = let
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
    ] (name: {
      openssh.authorizedKeys.keys = readKeys (./auth-keys + "/${name}");
    });
}
