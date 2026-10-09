{lib, ...}: let
  readKeys = keyPath: lib.splitString "\n" (builtins.readFile keyPath);
  users = [
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
  ];
in {
  flake.nixosModules = lib.genAttrs users (name: {
    users.users.${name}.openssh.authorizedKeys.keys =
      readKeys (./auth-keys + "/${name}");
  });
}
