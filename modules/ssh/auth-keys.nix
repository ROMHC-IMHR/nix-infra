{
  self,
  lib,
  ...
}: {
  flake.nixosModules =
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
    ] (user: {
      users.users.${user}.openssh.authorizedKeys.keys = self.lib.constants.userAuthPKs.${user};
    });
}
